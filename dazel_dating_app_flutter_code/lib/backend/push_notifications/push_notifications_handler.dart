import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF8232B4),
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Welcome': ParameterData.none(),
  'MainHome': ParameterData.none(),
  'MainAuth': ParameterData.none(),
  'Setting': ParameterData.none(),
  'Explore': ParameterData.none(),
  'ChatPage': ParameterData.none(),
  'DateFIlter': ParameterData.none(),
  'EditProfile': ParameterData.none(),
  'NotificationSettings': ParameterData.none(),
  'ProfileStrength': ParameterData.none(),
  'IntrestSelection': ParameterData.none(),
  'PickWrittenpromptPage': ParameterData.none(),
  'PickWrittePromptPage2EnterPrompt': ParameterData.none(),
  'ShowSelectWorkOccupationPage': ParameterData.none(),
  'AddOccupationPage': (data) async => ParameterData(
        allParams: {
          'edit': getParameter<bool>(data, 'edit'),
        },
      ),
  'ShowSelectEducationPage': ParameterData.none(),
  'AddEducationPage': (data) async => ParameterData(
        allParams: {
          'edit': getParameter<bool>(data, 'edit'),
        },
      ),
  'UpdateYourGender': ParameterData.none(),
  'PickYourGenderPronounsPage': ParameterData.none(),
  'EnterYourHeight': ParameterData.none(),
  'EnterExercise': ParameterData.none(),
  'EnterEducationLevel': ParameterData.none(),
  'EnterDrink': ParameterData.none(),
  'EnterSmoke': ParameterData.none(),
  'EnterKids': ParameterData.none(),
  'EnterStarSign': ParameterData.none(),
  'EnterPolitics': ParameterData.none(),
  'EnterReligion': ParameterData.none(),
  'LanguagesIKnow': ParameterData.none(),
  'ExploreProfile': (data) async => ParameterData(
        allParams: {
          'lookingFor': getParameter<String>(data, 'lookingFor'),
        },
      ),
  'SelectOpeningQuestion': ParameterData.none(),
  'SelectLocation': (data) async => ParameterData(
        allParams: {
          'hintText': getParameter<String>(data, 'hintText'),
        },
      ),
  'MainDiscoverPage': ParameterData.none(),
  'auth_3_Create': ParameterData.none(),
  'auth_3_Login': ParameterData.none(),
  'auth_3_phone': ParameterData.none(),
  'auth_3_verifyPhone': (data) async => ParameterData(
        allParams: {
          'phoneNumber': getParameter<String>(data, 'phoneNumber'),
        },
      ),
  'auth_3_ForgotPassword': ParameterData.none(),
  'Auth_Enter_Name': ParameterData.none(),
  'Auth_Enter_BOD': ParameterData.none(),
  'Auth_enter_gender': ParameterData.none(),
  'Auth_ProfilePicture': ParameterData.none(),
  'Auth_Enter_Bio': ParameterData.none(),
  'Auth_Looking_For': ParameterData.none(),
  'Auth_Intrested_in': ParameterData.none(),
  'VerifyProfile': ParameterData.none(),
  'GotMatch': ParameterData.none(),
  'ContactPage': ParameterData.none(),
  'SelectFoodPreferences': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
