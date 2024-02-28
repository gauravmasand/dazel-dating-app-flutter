import 'dart:async';

import 'package:dazel_dating_app/backend/models/user_data_model.dart';
import 'package:dazel_dating_app/pages/edit_profile/edit_profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../backend/LocalDatabase.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../../profile_create/auth_3_set_password/auth3_set_password_widget.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => (user == null || showSplashImage) && isUserLoggedInFlag;
  bool get loggedIn => !loading ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          isUserLoggedInFlag ? MainHomeWidget() : MainAuthWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
          isUserLoggedInFlag ? MainHomeWidget() : MainAuthWidget(),
        ),
        FFRoute(
          name: 'Welcome',
          path: '/welcome',
          builder: (context, params) => WelcomeWidget(),
        ),
        FFRoute(
          name: 'MainHome',
          path: '/mainHome',
          builder: (context, params) => MainHomeWidget(),
        ),
        FFRoute(
          name: 'MainAuth',
          path: '/mainAuth',
          builder: (context, params) => MainAuthWidget(),
        ),
        FFRoute(
          name: 'Setting',
          path: '/setting',
          builder: (context, params) => SettingWidget(),
        ),
        FFRoute(
          name: 'Explore',
          path: '/explore',
          builder: (context, params) => ExploreWidget(),
        ),
        FFRoute(
          name: 'ChatPage',
          path: '/chatPage',
          builder: (context, params) => ChatPageWidget(
            userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, doYouDrink: "", doYouWorkout: "", educationLevel: "", havingKids: "", height: "", politicalLearning: "", religiousBelief: "", smoke: "", starSign: "", spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, hometown: "", location: "", signupDateAndTime: "signupDateAndTime", version: 1),
          ),
        ),
        FFRoute(
          name: 'DateFIlter',
          path: '/dateFIlter',
          builder: (context, params) => DateFIlterWidget(),
        ),
        FFRoute(
          name: 'EditProfile',
          path: '/editProfile',
          builder: (context, params) => EditProfileWidget(),
        ),
        FFRoute(
          name: 'NotificationSettings',
          path: '/notificationSettings',
          builder: (context, params) => NotificationSettingsWidget(),
        ),
        FFRoute(
          name: 'ProfileStrength',
          path: '/profileStrength',
          builder: (context, params) => ProfileStrengthWidget(),
        ),
        FFRoute(
          name: 'IntrestSelection',
          path: '/intrestSelection',
          builder: (context, params) => IntrestSelectionWidget(),
        ),
        FFRoute(
          name: 'PickWrittenpromptPage',
          path: '/pickWrittenpromptPage',
          builder: (context, params) => PickWrittenpromptPageWidget(),
        ),
        FFRoute(
          name: 'PickWrittePromptPage2EnterPrompt',
          path: '/pickWrittePromptPage2EnterPrompt',
          builder: (context, params) =>
              PickWrittePromptPage2EnterPromptWidget(
                prompt: "",
                defaultAns: "",
              ),
        ),
        FFRoute(
          name: 'ShowSelectWorkOccupationPage',
          path: '/showSelectWorkOccupationPage',
          builder: (context, params) => ShowSelectWorkOccupationPageWidget(),
        ),
        FFRoute(
          name: 'AddOccupationPage',
          path: '/addOccupationPage',
          builder: (context, params) => AddOccupationPageWidget(
            edit: params.getParam('edit', ParamType.bool),
            model: WorkModel("", ""),
          ),
        ),
        FFRoute(
          name: 'ShowSelectEducationPage',
          path: '/showSelectEducationPage',
          builder: (context, params) => ShowSelectEducationPageWidget(),
        ),
        FFRoute(
          name: 'AddEducationPage',
          path: '/addEducationPage',
          builder: (context, params) => AddEducationPageWidget(
            edit: params.getParam('edit', ParamType.bool),
            model: EducationModel("", ""),
          ),
        ),
        FFRoute(
          name: 'UpdateYourGender',
          path: '/updateYourGender',
          builder: (context, params) => UpdateYourGenderWidget(),
        ),
        FFRoute(
          name: 'PickYourGenderPronounsPage',
          path: '/pickYourGenderPronounsPage',
          builder: (context, params) => PickYourGenderPronounsPageWidget(),
        ),
        FFRoute(
          name: 'EnterYourHeight',
          path: '/enterYourHeight',
          builder: (context, params) => EnterYourHeightWidget(),
        ),
        FFRoute(
          name: 'EnterExercise',
          path: '/enterExercise',
          builder: (context, params) => EnterExerciseWidget(),
        ),
        FFRoute(
          name: 'EnterEducationLevel',
          path: '/enterEducationLevel',
          builder: (context, params) => EnterEducationLevelWidget(),
        ),
        FFRoute(
          name: 'EnterDrink',
          path: '/enterDrink',
          builder: (context, params) => EnterDrinkWidget(),
        ),
        FFRoute(
          name: 'EnterSmoke',
          path: '/enterSmoke',
          builder: (context, params) => EnterSmokeWidget(),
        ),
        FFRoute(
          name: 'EnterKids',
          path: '/enterKids',
          builder: (context, params) => EnterKidsWidget(),
        ),
        FFRoute(
          name: 'EnterStarSign',
          path: '/enterStarSign',
          builder: (context, params) => EnterStarSignWidget(),
        ),
        FFRoute(
          name: 'EnterPolitics',
          path: '/enterPolitics',
          builder: (context, params) => EnterPoliticsWidget(),
        ),
        FFRoute(
          name: 'EnterReligion',
          path: '/enterReligion',
          builder: (context, params) => EnterReligionWidget(),
        ),
        FFRoute(
          name: 'LanguagesIKnow',
          path: '/languagesIKnow',
          builder: (context, params) => LanguagesIKnowWidget(),
        ),
        FFRoute(
          name: 'SelectOpeningQuestion',
          path: '/selectOpeningQuestion',
          builder: (context, params) => SelectOpeningQuestionWidget(),
        ),
        FFRoute(
          name: 'SelectLocation',
          path: '/selectLocation',
          builder: (context, params) => SelectLocationWidget(
            hintText: params.getParam('hintText', ParamType.String),
          ),
        ),
        // FFRoute(
        //   name: 'MainDiscoverPage',
        //   path: '/mainDiscoverPage',
        //   builder: (context, params) => MainDiscoverPageWidget(),
        // ),
        FFRoute(
          name: 'auth_3_Create',
          path: '/auth3Create',
          builder: (context, params) => Auth3CreateWidget(),
        ),
        FFRoute(
          name: 'auth_3_Login',
          path: '/auth3Login',
          builder: (context, params) => Auth3LoginWidget(),
        ),
        FFRoute(
          name: 'auth_3_phone',
          path: '/auth3Phone',
          builder: (context, params) => Auth3PhoneWidget(),
        ),
        FFRoute(
          name: 'auth_3_verifyPhone',
          path: '/auth3VerifyPhone',
          builder: (context, params) => Auth3VerifyPhoneWidget(
            phoneNumber: params.getParam('phoneNumber', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'auth_3_ForgotPassword',
          path: '/auth3ForgotPassword',
          builder: (context, params) => Auth3ForgotPasswordWidget(),
        ),
        FFRoute(
          name: 'auth_3_SetPassword',
          path: '/auth3SetPassword',
          builder: (context, params) => Auth3SetPasswordWidget(),
        ),
        FFRoute(
          name: 'Auth_Enter_Name',
          path: '/authEnterName',
          builder: (context, params) => AuthEnterNameWidget(),
        ),
        FFRoute(
          name: 'Auth_Enter_BOD',
          path: '/authEnterBOD',
          builder: (context, params) => AuthEnterBODWidget(),
        ),
        FFRoute(
          name: 'Auth_enter_gender',
          path: '/authEnterGender',
          builder: (context, params) => AuthEnterGenderWidget(),
        ),
        FFRoute(
          name: 'Auth_ProfilePicture',
          path: '/authProfilePicture',
          builder: (context, params) => AuthProfilePictureWidget(),
        ),
        FFRoute(
          name: 'Auth_Enter_Bio',
          path: '/authEnterBio',
          builder: (context, params) => AuthEnterBioWidget(),
        ),
        FFRoute(
          name: 'Auth_Looking_For',
          path: '/authLookingFor',
          builder: (context, params) => AuthLookingForWidget(),
        ),
        FFRoute(
          name: 'Auth_Intrested_in',
          path: '/authIntrestedIn',
          builder: (context, params) => AuthIntrestedInWidget(),
        ),
        FFRoute(
          name: 'VerifyProfile',
          path: '/verifyProfile',
          builder: (context, params) => VerifyProfileWidget(),
        ),
        FFRoute(
          name: 'GotMatch',
          path: '/gotMatch',
          builder: (context, params) => GotMatchWidget(
            id: "id",
            media: [],
            name: "name",
          ),
        ),
        FFRoute(
          name: 'ContactPage',
          path: '/contactPage',
          builder: (context, params) => ContactPageWidget(),
        ),
        FFRoute(
          name: 'SelectFoodPreferences',
          path: '/selectFoodPreferences',
          builder: (context, params) => SelectFoodPreferencesWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/mainAuth';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading && !ffParams.hasFutures
              ? SplashScreen()
              : PushNotificationsHandler(child: page);


          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
    routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
