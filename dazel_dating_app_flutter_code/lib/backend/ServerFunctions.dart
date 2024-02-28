import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:dazel_dating_app/backend/Constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

import 'LocalDatabase.dart';
import 'models/ChatsUsers.dart';
import 'models/ContactModel.dart';



// Function to get the current location
Future _getCurrentLocation() async {
  try {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return '';
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  } catch (e) {
    print(e);
  }
}

Future<void> updateUserLocation() async {
  String userId = await SharesPrefs.getValue('_id');
  final Uri uri = Uri.parse(Constants.url + '/api/operations/updateLocation/$userId');

  // Update user location function
  void updateLocation() async {
    try {
      Position position = await _getCurrentLocation();

      String lat = position.latitude.toString();
      String lang = position.longitude.toString();

      Constants.latitude = position.latitude;
      Constants.longitude = position.longitude;

      var data = {
        'latitude': lat,
        'longitude': lang,
      };

      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json', 'x-api-key': Constants.apiKey},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // User location updated successfully
        Vx.log('User location updated successfully');
      } else {
        // Handle error
        Vx.log('Failed to update user location. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      Vx.log('Error updating user location: $error');
    }
  }

  updateLocation();

  // // Set up a periodic timer to update every 10 seconds
  // const Duration updateInterval = Duration(minutes: 2);
  // Timer.periodic(updateInterval, (timer) {
  //   updateLocation();
  // });
}

Future<void> storeUserContacts() async {
  final Uri uri = Uri.parse('${Constants.url}/api/userdata/store-user-contacts');

  try {
    String userId = await SharesPrefs.getValue('_id');

    List<ContactModel> contacts = await getContacts();

    List<Map<String, dynamic>> contactsData = contacts.map((contact) {
      return {
        'name': contact.name ?? '',
        'phoneNumbers': contact.phoneNumbers ?? [],
        'emails': contact.emails ?? [],
      };
    }).toList();

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'x-api-key': Constants.apiKey},
      body: jsonEncode({
        'userId': userId,
        'contacts': contactsData,
      }),
    );

    if (response.statusCode == 200) {
      // User contacts stored successfully
      print('User contacts stored successfully');
    } else {
      // Handle error
      print('Failed to store user contacts. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error storing user contacts: $error');
  }
}

Future<List<ContactModel>> getContacts() async {
  var status = await Permission.contacts.request();

  if (status.isGranted) {


    List<ContactModel> userContacts = (await ContactsService.getContacts())
        .map((contact) => ContactModel.fromContact(contact))
        .toList();

    print(userContacts);

    return userContacts;
  } else {
    // Handle denied permission
    return [];
  }
}

Future<void> sendOnlineStatusToServer() async {
  Future<void> _sendUpdateRequest(uid) async {
    try {
      // Replace 'your_api_endpoint' with the actual API endpoint
      final response = await http.post(
        Uri.parse('${Constants.url}/api/analytics/update-last-active/${uid}'),
        headers: {'x-api-key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        print('Last active time: ${response.body}');
      }
    } catch (error) {
      print('Error sending update request: $error');
    }
  }
  String userId = await SharesPrefs.getValue('_id');
  Timer.periodic(Duration(seconds: 5), (timer) {
    _sendUpdateRequest(userId);
  });
}

Future<void> sendMessage({
  required String userId,
  required String receiverId,
  required String message,
  List<File>? files,
}) async {
  final Uri apiUrl = Uri.parse('${Constants.url}/api/chat/send-message');

  try {
    final request = http.MultipartRequest('POST', apiUrl)
      ..headers.addAll({
        'Content-Type': 'multipart/form-data',
        'X-API-Key': Constants.apiKey,
      })
      ..fields.addAll({
        'userId': userId,
        'receiverId': receiverId,
        'message': message,
      });

    // Attach media files
    if (files != null) {
      for (File file in files) {
        request.files.add(
          await http.MultipartFile.fromPath('files', file.path!),
        );
      }
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      // Handle successful response
      print('Message sent successfully');
    } else {
      // Handle error response
      print('Error: ${await response.stream.bytesToString()}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error: $error');
  }
}


Future fetchAllChats() async {

  try {
    String userId = await SharesPrefs.getValue('_id');
    final String apiUrl = '${Constants.url}/api/chat/all-chats/$userId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'x-api-key': Constants.apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> conversationsData = responseData['conversations'];

      // Convert the raw conversation data into Conversation objects
      final List<ChatsUsersModel> conversations = conversationsData
          .map((conversation) => ChatsUsersModel.fromApiResponse(conversation))
          .toList();

      return conversations;
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

Future<void> markMessagesAsSeen(String receiverId) async {
  String userId = await SharesPrefs.getValue('_id');
  final apiUrl = '${Constants.url}/api/chat/mark-seen';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': Constants.apiKey,
      },
      body: jsonEncode({
        'userId': userId,
        'receiverId': receiverId,
      }),
    );

    if (response.statusCode == 200) {
      print('Messages marked as seen successfully');
    } else {
      print('Failed to mark messages as seen: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> sendContact(String title, String description) async {

  String userId = await SharesPrefs.getValue('_id');
  final url = Uri.parse('${Constants.url}/api/contact');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Constants.apiKey
      },
      body: jsonEncode({
        'userId': userId,
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully created contact
      print('Contact created successfully');
    } else {
      // Handle errors, e.g., display an error message to the user
      print('Failed to create contact. Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network or other errors
    print('Error creating contact: $e');
  }
}

Future<Map<String, dynamic>> enableSpotlight(userId) async {
  try {

    final url = Constants.url + '/api/operations/enable-spotlight';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'x-api-key': Constants.apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Spotlight enabled successfully'};
    } else {
      throw Exception('Failed to enable spotlight: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return {'success': false, 'message': 'Failed to enable spotlight'};
  }
}

Future<int> updateIncognitoMode(userId, bool enableIncognito) async {

  final apiUrl = Constants.url + '/api/operations/incognito/$userId';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Constants.apiKey
      },
      body: jsonEncode({'incognitoMode': enableIncognito}),
    );

    if (response.statusCode == 200) {
      print('Incognito mode updated successfully');
    } else {
      print('Failed to update incognito mode. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return response.statusCode;
  } catch (error) {
    // Handle network or other errors
    print('Error updating incognito mode: $error');
    return 500;
  }
}
