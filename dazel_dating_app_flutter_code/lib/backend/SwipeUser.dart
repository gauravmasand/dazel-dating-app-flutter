import 'dart:convert';

import 'package:dazel_dating_app/backend/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'LocalDatabase.dart';



Future<void> updateAcceptStatus(String otherUserId, bool accepted) async {
  String currentUserId = await SharesPrefs.getValue('_id');
  final String apiUrl = '${Constants.url}/api/swipe/updateSwipeAcceptanceStatus';

  try {
    final response = await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'currentUserId': currentUserId,
        'otherUserId': otherUserId,
        'accepted': accepted,
      }),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Constants.apiKey
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('API Response: $responseData');
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      print('API Error: $errorData');
    }
  } catch (error) {
    print('Error calling API: $error');
  }
}


Future swipeRight({required String otherUserId, Map? message}) async {

  message ??= {'msg': "", 'type': "swipe", 'data': ""};

  var userId = await SharesPrefs.getValue('_id');

  var url = Constants.url + '/api/swipe/right';

  final Map<String, dynamic> requestData = {
    'userId': userId,
    'otherUserId': otherUserId,
    'message': jsonEncode(message),
  };

  final http.Response response = await http.post(
    Uri.parse(url),
    body: requestData,
    headers: {
      'x-api-key': Constants.apiKey
    },
  );

  // Handle the response as needed
  Vx.log(response.statusCode.toString() + "  " + json.decode(response.body).toString());
  if (response.statusCode == 200) {
    return json.decode(response.body)['message'];
  } else {
    print('Right swipe failed. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return ['message'];
  }
}

Future<void> swipeLeft(String otherUserId) async {

  var userId = await SharesPrefs.getValue('_id');

  var url = Constants.url + '/api/swipe/left';

  final Map<String, dynamic> requestData = {
    'userId': userId,
    'otherUserId': otherUserId,
  };

  final http.Response response = await http.post(
    Uri.parse(url),
    body: requestData,
    headers: {
      'x-api-key': Constants.apiKey
    },
  );

  // Handle the response as needed
  if (response.statusCode == 200) {
    print('Left swipe successful');
  } else {
    print('Left swipe failed. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
