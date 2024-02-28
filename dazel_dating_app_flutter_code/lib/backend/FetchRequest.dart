import 'dart:convert';
import 'package:dazel_dating_app/backend/Constants.dart';
import 'package:dazel_dating_app/backend/models/MatchUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import 'LocalDatabase.dart';
import 'models/ChatMessage.dart';
import 'models/GotRightSwipeUserModel.dart';
import 'models/user_data_model.dart';

class Fetch {

  static Future<Map<String, dynamic>> fetchUserDetails({String? email, String? userId}) async {
    final apiUrl = Constants.url+'/api/fetch/user-details';

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?${email != null ? 'email=$email' : 'userId=$userId'}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': Constants.apiKey
        },
      );

      if (response.statusCode == 200) {
        // Successful response, return user data
        return {
          "status": true,
          "data": jsonDecode(response.body)
        };
      } else if (response.statusCode == 404) {
        // User not found
        return {
          "status": false,
          'error': 'User not found'
        };
      } else {
        // Handle other errors
        return {
          "status": false,
          'error': 'An error occurred'
        };
      }
    } catch (e) {
      // Exception occurred during API call
      return {
        "status": false,
        'error': 'Exception: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> fetchUsersProfiles() async {
    var currentUserId = await SharesPrefs.getValue("_id");
    var basics = await SharesPrefs.getValue("basicInfo");
    var oppositeGender = basics['gender'] == "Men" ? 'Women' : "Men";

    Vx.log(oppositeGender);

    final String apiUrl = '${Constants.url}/api/fetch/fetch-users/$currentUserId/${oppositeGender}';

    try {
      // Parse the response body
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': Constants.apiKey
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> usersData = data['users'];
        final List<UserData> users = usersData
            .map((userData) => UserData.fromJson(userData))
            .toList();

        return {'success': true, 'users': users};
      } else {
        Vx.log(response.statusCode);
        // Handle error and return an error message
        return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (error) {

      Vx.log(error);
      // Handle network or other errors and return an error message
      return {'success': false, 'error': 'Error: $error'};
    }
  }

  static Future<Map<String, dynamic>> fetchBestMatchUsersProfiles() async {
    try {
      var currentUserId = await SharesPrefs.getValue("_id");
      var basics = await SharesPrefs.getValue("basicInfo");

      var oppositeGender = basics['gender'] == "Men" ? 'Women' : "Men";

      final String apiUrl = '${Constants.url}/api/fetch/fetch-best-match/$currentUserId/$oppositeGender';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': Constants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> usersData = data['users'];
        final List<UserData> users = usersData
            .map((userData) => UserData.fromJson(userData))
            .toList();

        return {'success': true, 'users': users};
      } else {
        Vx.log(response.statusCode);
        return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (error) {
      Vx.log(error);
      return {'success': false, 'error': 'Error: $error'};
    }
  }

  static Future<Map<String, dynamic>> fetchSpecificTypeOfDate(type) async {
    try {
      var currentUserId = await SharesPrefs.getValue("_id");
      var basics = await SharesPrefs.getValue("basicInfo");

      var oppositeGender = basics['gender'] == "Men" ? 'Women' : "Men";

      final String apiUrl = '${Constants.url}/api/fetch/fetch-explore-users/$currentUserId/$oppositeGender';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': Constants.apiKey,
        },
        body: jsonEncode({
          'typeOfDate': type
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> usersData = data['users'];
        final List<UserData> users = usersData
            .map((userData) => UserData.fromJson(userData))
            .toList();

        return {'success': true, 'users': users};
      } else {
        Vx.log(response.statusCode);
        return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (error) {
      Vx.log(error);
      return {'success': false, 'error': 'Error: $error'};
    }
  }

  static Future<List<GotRightSwipeUserModel>> fetchGotRightSwipeUsers() async {

    String userId = await SharesPrefs.getValue('_id');

    final String apiUrl = '${Constants.url}/api/fetch/got-right-swipe/$userId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': Constants.apiKey
      },
    );

    Vx.log(json.decode(response.body).toString());

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<dynamic> gotRightSwipeUsersDetails = jsonData['gotRightSwipeUsersDetails'];

      Vx.log(gotRightSwipeUsersDetails);

      return gotRightSwipeUsersDetails
          .map((userData) => GotRightSwipeUserModel.fromJson(userData))
          .toList();
    } else {
      throw Exception('Failed to load got right swipe users');
    }
  }

  static Future fetchProfileCompletion() async {

    final userId = await SharesPrefs.getValue('_id');

    final response = await http.get(
      Uri.parse(Constants.url + '/api/auth/profileCompletionScore/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': Constants.apiKey
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['profileCompletionPercentage'].toString();
    } else {
      return '-1';
    }
  }

  static Future<List<MatchedUserModel>> fetchMatchedUsers() async {
    final userId = await SharesPrefs.getValue('_id');
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}/api/fetch/match-list/$userId'),
        headers: {'x-api-key' : Constants.apiKey}
      );

      if (response.statusCode == 200) {
        final List<dynamic> matchedUsersJson = json.decode(response.body)['matchedUsersDetails'];
        final List<MatchedUserModel> matchedUsers = matchedUsersJson
            .map((userJson) => MatchedUserModel.fromJson(userJson))
            .toList();

        // Now you have a list of matched users in the 'matchedUsers' variable
        print('Matched Users:');
        matchedUsers.forEach((user) {
          print('ID: ${user.id}, Name: ${user.name}, Media: ${user.media}');
        });
        return matchedUsers;
      } else {
        print('API Error: ${json.decode(response.body)}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getUserOnlineStatus(String userId) async {
    final String apiUrl = '${Constants.url}/api/fetch/user-online-status/$userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-api-key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['isOnline'];
      } else {
        throw Exception('Failed to get user online status');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  static Future getLastActiveStatus(String userId) async {
    final String apiUrl = '${Constants.url}/api/fetch/last-active-status/$userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-api-key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['lastActive'];
      } else {
        throw Exception('Failed to get last active status');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  static Future<List<ChatMessage>> fetchChat(String user2Id, {sinceTimestamp}) async {
    final user1Id = await SharesPrefs.getValue('_id');
    final url = '${Constants.url}/api/chat/fetch-chat';

    try {
      Map<String, dynamic> requestBody = {
        'user1Id': user1Id,
        'user2Id': user2Id,
      };

      // Add sinceTimestamp to the request if provided
      if (sinceTimestamp != null) {
        requestBody['sinceTimestamp'] = sinceTimestamp;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': Constants.apiKey
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final conversation = responseBody['messages'];
        Vx.log("The message is got is "+conversation.toString());

        if (conversation != null && conversation.isNotEmpty) {
          final List<dynamic> messages = conversation ?? [];
          return messages
              .map<ChatMessage>((message) => ChatMessage.fromJson(message))
              .toList();
        } else {
          Vx.log("No new Messages");

          return [];
        }
      } else {
        throw Exception('Failed to fetch chat');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future fetchLikesAndMatchesCount() async {
    try {
      final userId = await SharesPrefs.getValue('_id');
      final url = Constants.url+'/api/fetch/get-likes-and-matches';

      final response = await http.get(
        Uri.parse('$url?userId=$userId'),
        headers: {'x-api-key': Constants.apiKey},
      );

      Vx.log("idk how"+response.body);


      if (response.statusCode == 200) {
        return json.decode(response.body);

      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  static Future<Map<String, dynamic>> getSpotlightInfo() async {
    try {

      final userId = await SharesPrefs.getValue('_id');

      final url = Constants.url+'/api/fetch/get-spotlight-info?userId=$userId';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': Constants.apiKey},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

}