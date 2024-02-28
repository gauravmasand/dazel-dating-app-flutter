import 'dart:convert';
import 'dart:io';

import 'package:dazel_dating_app/backend/FetchRequest.dart';
import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../backend/Constants.dart';
import '../backend/Function.dart';
import '../backend/models/signup_model.dart';

class MainAuth {

  static late bool isGoogleSignup;

  static bool emailExist = false;

  // Function to update the user profile
  static Future updateUserProfile(context, Map<String, dynamic> data) async {
    var userId = await SharesPrefs.getValue("_id");
    final String apiUrl = '${Constants.url}/api/auth/editprofile/$userId';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-api-key': Constants.apiKey
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {

        Vx.log('Your profile updated successfully' + response.body);

        return jsonDecode(response.body);

      } else {
        VxToast.show(context, msg: 'Failed to update user profile. Status code: ${response
            .statusCode}');
        // Handle other status codes or errors
      }
    } catch (error) {
      Vx.log('Error updating user profile: $error');
      // Handle the error
    }
  }

  static Future uploadMedia(context, List listOfImages) async {
    try {

      var userId = await SharesPrefs.getValue("_id");

      var uri = Uri.parse(Constants.url+'/api/auth/upload-media/${userId}');

      var request = http.MultipartRequest('POST', uri);

      request.headers['x-api-key'] = Constants.apiKey;

      // Attach media files
      for (File image in listOfImages) {
        // Assuming SelectedByte has a property containing the image path
        request.files.add(await http.MultipartFile.fromPath('media', image.path));
      }

      var responseStreamed = await request.send();
      var response = await http.Response.fromStream(responseStreamed);

      if (response.statusCode == 200) {
      // Media upload successfully
        var responseBody = await response.body;
        var media = jsonDecode(responseBody);
        SharesPrefs.setValue('media', media);
        Vx.log("Local database " + SharesPrefs.getValue('media').toString());

        return {
          'status': true,
          'media': media
        };
      } else {
        // Handle failure
        Vx.log('Upload Failed: ${response.statusCode}');
        return {
          'status': false,
          'error': "Something went wrong please try after some time"
        };
      }
    } catch (e) {
      VxToast.show(context, msg: "$e");
      return {
        'status': false,
        'error': "Internal Server error occur,\nPlease try after some time"
      };
    }
  }

  static Future signup(context) async {
    try {
      var uri = Uri.parse(Constants.url+'/api/auth/signup');

      var request = http.MultipartRequest('POST', uri)
        ..fields['phoneNumber'] = standardizePhoneNumber(SignupModel.phone)
        ..fields['email'] = SignupModel.email
        ..fields['password'] = SignupModel.password
        ..fields['name'] = SignupModel.name
        ..fields['dob'] = SignupModel.dob
        ..fields['gender'] = SignupModel.gender
        ..fields['typeOfDate'] = SignupModel.lookingFor
        ..fields['interestsRaw'] = SignupModel.interestedIn.join(',')
        ..fields['accountSignupType'] = MainAuth.isGoogleSignup ? "Google" : "Manual";

      request.headers['x-api-key'] = Constants.apiKey;

      // Attach media files
      for (File imageFuture in SignupModel.listOfImages) {
        // Assuming SelectedByte has a property containing the image path
        File imageFile = await imageFuture;
        request.files.add(await http.MultipartFile.fromPath('media', imageFile.path));
      }

      var responseStreamed = await request.send();
      var response = await http.Response.fromStream(responseStreamed);

      if (response.statusCode == 200) {
        // Successful signup
        var responseBody = response.body;
        return {
          'statusCode': response.statusCode,
          'data': jsonDecode(responseBody)
        };
      } else if (response.statusCode == 400) {
        // Handle failure
        Vx.log('Signup failed: ${response.statusCode}');
        return {
          'statusCode': response.statusCode,
          'error': "The email is already signup in app"
        };
      } else {
        // Handle failure
        Vx.log('Signup failed: ${response.statusCode}');
        return {
          'statusCode': response.statusCode,
          'error': "Something went wrong please try after some time"
        };
      }

    } catch (e) {
      // Handle exceptions
      // VxToast.show(context, msg: "$e");
      return {
        'statusCode': -1,
        'error': "Internal Server error occur,\nPlease try after some time"
      };
    }
  }

  static Future checkEmailExistence(String email) async {
    final url = Uri.parse(Constants.url+'/api/auth/check-email');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key' : Constants.apiKey
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.body == "true") {
        return true;
      } else {
        return false;
      }

      // return response.body;

    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final apiUrl = Constants.url+'/api/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key' : Constants.apiKey
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      Vx.log(jsonDecode(response.body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
        };
      } else if (response.statusCode == 401) {
        // Invalid password
        return {'success': false, 'error': 'Invalid password', 'type': 'password'};
      } else if (response.statusCode == 404) {
        // User not found
        return {'success': false, 'error': 'User not found', 'type': 'email'};
      } else {
        // Handle other errors
        return {'success': false, 'error': 'Something went wrong, Please try after some time'};
      }
    } catch (e) {
      // Exception occurred during API call
      return {'success': false, 'error': 'Error: $e'};
    }
  }

}

class GoogleSignInAPI {

  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.disconnect();

  static Future signIn(BuildContext context) async {

    final user = await login();

    if (user==null) {

      Vx.log("user is null");

    } else {

      Vx.log("User is not null");

      Map<String, dynamic> userData = await Fetch.fetchUserDetails(email: user.email);

      if (userData['status'] == true) {

        Vx.log("User already exist");

        SharesPrefs.setUserData(userData['data']);

        context.pushNamedAuth(
            'MainHome',
            context.mounted);

      } else {

        Vx.log("It's new user");

        SignupModel.email = user.email;
        SignupModel.name = user.displayName!;

        context.pushNamedAuth(
            'auth_3_phone',
            context.mounted);

      }

    }
  }

}