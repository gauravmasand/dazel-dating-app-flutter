import 'package:dazel_dating_app/backend/models/signup_model.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth_looking_for_model.dart';
export 'auth_looking_for_model.dart';

class AuthLookingForWidget extends StatefulWidget {
  const AuthLookingForWidget({Key? key}) : super(key: key);

  @override
  _AuthLookingForWidgetState createState() => _AuthLookingForWidgetState();
}

class _AuthLookingForWidgetState extends State<AuthLookingForWidget>
    with TickerProviderStateMixin {
  late AuthLookingForModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0, 0.524),
          end: Offset(0, 0),
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(70.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthLookingForModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Auth_Looking_For'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryBackground,
                            FlutterFlowTheme.of(context).accent1
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(1.0, 0.0),
                          end: AlignmentDirectional(-1.0, 0),
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 570.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        alignment: AlignmentDirectional(0.00, -1.00),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                alignment: AlignmentDirectional(-1.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: Icon(
                                          Icons.flourescent_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 44.0,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'inulmlvc' /* Dazel */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 12.0),
                                        child: FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderRadius: 12.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          icon: Icon(
                                            Icons.arrow_back_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'AUTH_LOOKING_FOR_arrow_back_rounded_ICN_');
                                            logFirebaseEvent(
                                                'IconButton_navigate_back');
                                            context.safePop();
                                          },
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'dbkmwcg1' /* Cosmic Quest Preferences! */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 24.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '1hm003io' /* What's your cosmic mission? Te... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 250.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: GridView(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            ItemCard("💘", "Long Term partner", 15.0),
                                            ItemCard("😘", "Short Term,\nbut\nLong Term", 11.0),
                                            ItemCard("😍", "Long Term\nbut\nShort Term", 11.0),
                                            ItemCard("🥂", "New Friends", 15.0),
                                            ItemCard("🥰", "Short-Term fun", 15.0),
                                            ItemCard("🫠", "Friends for Fun", 15.0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ItemCard(emoji, text, font) {
    return InkWell(
      onTap: () {
        logFirebaseEvent(
            'AUTH_LOOKING_FOR_CONTINUE_BTN_ON_TAP');
        logFirebaseEvent(
            'Button_navigate_to');

        SignupModel.lookingFor = text;

        context.pushNamed(
            'Auth_Intrested_in');
      },
      child: Card(
        clipBehavior:
        Clip.antiAliasWithSaveLayer,
        color:
        FlutterFlowTheme.of(context)
            .secondaryBackground,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional
              .fromSTEB(
              5.0, 5.0, 5.0, 0.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(
                  0.0),
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.max,
              mainAxisAlignment:
              MainAxisAlignment
                  .center,
              children: [
                Padding(
                  padding:
                  EdgeInsetsDirectional
                      .fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      5.0),
                  child: Text(
                    emoji,
                    textAlign:
                    TextAlign.center,
                    style: FlutterFlowTheme
                        .of(context)
                        .titleSmall
                        .override(
                      fontFamily:
                      'Inter',
                      color: FlutterFlowTheme.of(
                          context)
                          .primaryText,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Text(
                  text,
                  textAlign:
                  TextAlign.center,
                  style:
                  FlutterFlowTheme.of(
                      context)
                      .titleSmall
                      .override(
                    fontFamily:
                    'Inter',
                    color: FlutterFlowTheme.of(
                        context)
                        .primaryText,
                    fontSize:
                    font,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
