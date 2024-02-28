import 'dart:async';

import 'package:dazel_dating_app/backend/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

import '../LocalDatabase.dart';

class InstagramLoginScreen extends StatefulWidget {
  @override
  State<InstagramLoginScreen> createState() => _InstagramLoginScreenState();
}

class _InstagramLoginScreenState extends State<InstagramLoginScreen> {
  final String clientId = '359120176863129';

  final String clientSecret = '57d7b3230eae101db312b310d664dc5d';

  final String redirectUri = 'https://socialsizzle.herokuapp.com/auth/';
  // final String redirectUri = Constants.url+'/api/auth/instagram-connect';
  final String scope = 'user_profile,user_media';

  // code:- AQD4PcRe6XjC6YyXs4FKIAZRiGXw_SBQOCk_JDi7AQFdZjtOfGXsLve4a2U-oTYf-S4otJi-wlrfzSxACBHl5Wjtt__YzAvbfp2kthpdJpCDPqEQtaSNxPOI5G8PGUx-LAdcakEzChyH83gvZeaOBQGs0LgNwwaYY3DEu3stwUnZI7fzGshSnoI3oKToLTkE5PwZwr557w4Z94kUqOq_Vx503yWavIPE_02t8GeIlhvq7Q

  bool _authorizationCompleted = false;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  // Works fine for mobile.uiux account
  Future<void> _getTokenFromInstagram(String code) async {
    try {
      await handleInstagramRedirect(code);
    } catch (error) {
      Vx.log('Error getting token from Instagram: $error');
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    super.initState();
    launchInstagramAuth();
    exchangeCodeForAccessToken("AQD4PcRe6XjC6YyXs4FKIAZRiGXw_SBQOCk_JDi7AQFdZjtOfGXsLve4a2U-oTYf-S4otJi-wlrfzSxACBHl5Wjtt__YzAvbfp2kthpdJpCDPqEQtaSNxPOI5G8PGUx-LAdcakEzChyH83gvZeaOBQGs0LgNwwaYY3DEu3stwUnZI7fzGshSnoI3oKToLTkE5PwZwr557w4Z94kUqOq_Vx503yWavIPE_02t8GeIlhvq7Q#_");
  }

  Future<void> handleInstagramRedirect(String code) async {
    try {
      final accessToken = await exchangeCodeForAccessToken(code);

      // Use accessToken to make requests to Instagram Graph API
      final userMediaResponse = await http.get(
        Uri.parse('https://graph.instagram.com/v12.0/me/media?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp&access_token=${accessToken['access_token']}'),
      );

      if (userMediaResponse.statusCode == 200) {
        final Map<String, dynamic> userMediaData = json.decode(userMediaResponse.body);
        List<dynamic> userMediaList = userMediaData['data'];

        // Process and display userMediaList as needed
        Vx.log('User Media List: $userMediaList');
      } else {
        Vx.log('Failed to fetch user media');

      }
    } catch (error) {
      Vx.log('Error handling Instagram redirect: $error');
    }
  }

  Future<void> launchInstagramAuth() async {
    final authorizationUrl = Uri.parse(
      'https://api.instagram.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&response_type=code&user_id=${await SharesPrefs.getValue("_id")}',
    );

    try {
      await launch(authorizationUrl.toString());
      // Wait for authorization to complete (this can be handled based on your app's navigation)
    } catch (e) {
      // Handle error
      print('Error launching Instagram authorization URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to Instagram'),
      ),
      // body: WebView(
      //   initialUrl:
      //   'https://api.instagram.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&response_type=code&uid=',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller.complete(webViewController);
      //   },
      //   navigationDelegate: (NavigationRequest request) async {
      //     if (request.url.startsWith(redirectUri)) {
      //       // Extract the authorization code
      //       Uri uri = Uri.parse(request.url);
      //       String? code = uri.queryParameters['code'];
      //       Vx.log(code);
      //       Vx.log(code);
      //       // Now, you can use the code as needed
      //       if (code != null) {
      //         // Pass the code to your method for further processing
      //         _getTokenFromInstagram(code);
      //       }
      //       // Prevent WebView from navigating further
      //       return NavigationDecision.prevent;
      //     }
      //     // Allow WebView to navigate
      //     return NavigationDecision.navigate;
      //   },
      // ),
    );
  }
}

//IGQWRNZAVJZAMjFQMUVFWm1ybGNZAZA2JzX0hqU0x2VUlGSDJpUW53WHZAxOUlIZAWxpRkpSZA1dnXzhoSUR3TDNNYjYtZAi1GN2Y3d2hBRVYwUmEydlJaV0dxMlV0NFB5djBIUHJsN3ZAXc0t1ZAEdaSENDcjYwajRRVEFWWGcZD

Future<Map<String, dynamic>> exchangeCodeForAccessToken(String code) async {
  final response = await http.post(
    Uri.parse('https://api.instagram.com/oauth/access_token'),
    body: {
      'client_id': '359120176863129',
      'client_secret': '57d7b3230eae101db312b310d664dc5d',
      'grant_type': 'authorization_code',  // Set to 'authorization_code'
      'redirect_uri': 'https://socialsizzle.herokuapp.com/auth/',
      'code': code,

    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    Vx.log({
      'success': true,
      'access_token': data['access_token'],
    });
    return {
      'success': true,
      'access_token': data['access_token'],
    };
  } else {
    final Map<String, dynamic> errorData = json.decode(response.body);
    Vx.log({
      'success': false,
      'error': 'Failed to exchange code for access token',
      'error_description': errorData['error_description'],
    });
    return {
      'success': false,
      'error': 'Failed to exchange code for access token',
      'error_description': errorData['error_description'],
    };
  }
}

Future<void> fetchInstagramPosts(String accessToken) async {
  final String apiUrl = 'https://graph.instagram.com/v12.0/me/media?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp&access_token=$accessToken';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse and handle the response data
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> posts = data['data'];

      // Process the posts as needed
      for (var post in posts) {
        print('Post ID: ${post['id']}');
        print('Caption: ${post['caption']}');
        print('Media Type: ${post['media_type']}');
        print('Media URL: ${post['media_url']}');
        print('Timestamp: ${post['timestamp']}');
        print('-----------------------------');
      }
    } else {
      // Handle API error
      print('Failed to fetch Instagram posts. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error during API call: $error');
  }
}

