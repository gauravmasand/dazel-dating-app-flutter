import 'package:dazel_dating_app/auth/MainAuth.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../backend/FetchRequest.dart';
import '../../backend/LocalDatabase.dart';
import '../../backend/ServerFunctions.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/snooze_component_widget.dart';
import '/components/video_auto_play_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_model.dart';
export 'setting_model.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  late SettingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _getData() async {
    bool incognitoMode = await SharesPrefs.getValue('incognitoMode');
    _model.switchValue1 = incognitoMode;

    setState(() {});

    Vx.log("_model.switchValue1.toString() "+_model.switchValue1.toString());

  }

  _updateIncognito(flag) async {
    String userId = await SharesPrefs.getValue('_id');
    await updateIncognitoMode(userId, flag);
    setState(() {});

    Map<String, dynamic> userData = await Fetch.fetchUserDetails(
      userId: userId
    );
    if (userData['status'] == true) {
      SharesPrefs.setUserData(userData['data']);
      setState(() {
        _getData();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingModel());


    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Setting'});

    _getData();

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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 46.0,
          icon: Icon(
            Icons.chevron_left,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
          onPressed: () async {
            logFirebaseEvent('SETTING_PAGE_chevron_left_ICN_ON_TAP');
            logFirebaseEvent('IconButton_navigate_back');
            context.pop();
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'hyp6vw3i' /* Settings */,
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          // Builder(
          //   builder: (context) => Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
          //     child: InkWell(
          //       splashColor: Colors.transparent,
          //       focusColor: Colors.transparent,
          //       hoverColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       onTap: () async {
          //         logFirebaseEvent('SETTING_PAGE_materialList_Item_2_ON_TAP');
          //         logFirebaseEvent('materialList_Item_2_alert_dialog');
          //         await showAlignedDialog(
          //           context: context,
          //           isGlobal: true,
          //           avoidOverflow: false,
          //           targetAnchor: AlignmentDirectional(0.0, 0.0)
          //               .resolve(Directionality.of(context)),
          //           followerAnchor: AlignmentDirectional(0.0, 1.0)
          //               .resolve(Directionality.of(context)),
          //           builder: (dialogContext) {
          //             return Material(
          //               color: Colors.transparent,
          //               child: Container(
          //                 height: MediaQuery.sizeOf(context).height * 0.45,
          //                 width: double.infinity,
          //                 child: SnoozeComponentWidget(),
          //               ),
          //             );
          //           },
          //         ).then((value) => setState(() {}));
          //       },
          //       child: Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50.0),
          //           border: Border.all(
          //             color: Color(0x32000000),
          //             width: 0.7,
          //           ),
          //         ),
          //         child: Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
          //           child: Row(
          //             mainAxisSize: MainAxisSize.max,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 FFLocalizations.of(context).getText(
          //                   'gj8nmn0r' /* Snooze */,
          //                 ),
          //                 style:
          //                     FlutterFlowTheme.of(context).titleLarge.override(
          //                           fontFamily: 'Sora',
          //                           fontSize: 18.0,
          //                         ),
          //               ),
          //               Icon(
          //                 Icons.chevron_right_rounded,
          //                 color: FlutterFlowTheme.of(context).secondaryText,
          //                 size: 24.0,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 0.0),
          //   child: Text(
          //     FFLocalizations.of(context).getText(
          //       '2ht1z97w' /* Temprovary hide your profile f... */,
          //     ),
          //     textAlign: TextAlign.start,
          //     style: FlutterFlowTheme.of(context).titleLarge.override(
          //           fontFamily: 'Sora',
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           fontSize: 14.0,
          //         ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Color(0x32000000),
                  width: 0.7,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 16.0, 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'qslfkcgc' /* Incognito Mode */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Sora',
                            fontSize: 18.0,
                          ),
                    ),
                    Switch.adaptive(
                      value: _model.switchValue1,
                      onChanged: (newValue) {
                        _updateIncognito(newValue);
                      },
                      activeColor: FlutterFlowTheme.of(context).primary,
                      activeTrackColor: FlutterFlowTheme.of(context).accent1,
                      inactiveTrackColor:
                          FlutterFlowTheme.of(context).alternate,
                      inactiveThumbColor:
                          FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 0.0),
            child: Text(
              FFLocalizations.of(context).getText(
                '1vbqpa3w' /* In this mode no will be able t... */,
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Sora',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                  ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
          //   child: Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50.0),
          //       border: Border.all(
          //         color: Color(0x32000000),
          //         width: 0.7,
          //       ),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 16.0, 5.0),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             FFLocalizations.of(context).getText(
          //               'skb71kjb' /* Auto-Spotlight */,
          //             ),
          //             style: FlutterFlowTheme.of(context).titleLarge.override(
          //                   fontFamily: 'Sora',
          //                   fontSize: 18.0,
          //                 ),
          //           ),
          //           Switch.adaptive(
          //             value: _model.switchValue2,
          //             onChanged: (newValue) async {
          //               setState(() => _model.switchValue2 = newValue!);
          //             },
          //             activeColor: FlutterFlowTheme.of(context).primary,
          //             activeTrackColor: FlutterFlowTheme.of(context).accent1,
          //             inactiveTrackColor:
          //                 FlutterFlowTheme.of(context).alternate,
          //             inactiveThumbColor:
          //                 FlutterFlowTheme.of(context).secondaryText,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 0.0),
          //   child: Text(
          //     FFLocalizations.of(context).getText(
          //       'mulvgak9' /* Automatically boost your profi... */,
          //     ),
          //     textAlign: TextAlign.start,
          //     style: FlutterFlowTheme.of(context).titleLarge.override(
          //           fontFamily: 'Sora',
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           fontSize: 14.0,
          //         ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 0.0),
          //   child: Text(
          //     FFLocalizations.of(context).getText(
          //       'vyjtq3c3' /* Location */,
          //     ),
          //     textAlign: TextAlign.start,
          //     style: FlutterFlowTheme.of(context).labelMedium.override(
          //           fontFamily: 'Inter',
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
          //   child: Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50.0),
          //       border: Border.all(
          //         color: Color(0x32000000),
          //         width: 0.7,
          //       ),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             FFLocalizations.of(context).getText(
          //               'd9fm815g' /* Current Location */,
          //             ),
          //             style: FlutterFlowTheme.of(context).titleLarge.override(
          //                   fontFamily: 'Sora',
          //                   fontSize: 18.0,
          //                 ),
          //           ),
          //           Row(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Text(
          //                 FFLocalizations.of(context).getText(
          //                   'pxrbllns' /* Pune, IN */,
          //                 ),
          //                 style: FlutterFlowTheme.of(context)
          //                     .titleLarge
          //                     .override(
          //                       fontFamily: 'Sora',
          //                       color:
          //                           FlutterFlowTheme.of(context).secondaryText,
          //                       fontSize: 16.0,
          //                     ),
          //               ),
          //               Icon(
          //                 Icons.chevron_right_rounded,
          //                 color: FlutterFlowTheme.of(context).secondaryText,
          //                 size: 24.0,
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
          //   child: Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: FlutterFlowTheme.of(context).tertiary,
          //       borderRadius: BorderRadius.circular(50.0),
          //       border: Border.all(
          //         color: Color(0x32000000),
          //         width: 0.7,
          //       ),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Row(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsetsDirectional.fromSTEB(
          //                     0.0, 0.0, 10.0, 0.0),
          //                 child: Icon(
          //                   Icons.travel_explore_outlined,
          //                   color:
          //                       FlutterFlowTheme.of(context).primaryBackground,
          //                   size: 24.0,
          //                 ),
          //               ),
          //               Text(
          //                 FFLocalizations.of(context).getText(
          //                   'qcf3u2h0' /* Travel */,
          //                 ),
          //                 style:
          //                     FlutterFlowTheme.of(context).titleLarge.override(
          //                           fontFamily: 'Sora',
          //                           color: FlutterFlowTheme.of(context)
          //                               .primaryBackground,
          //                           fontSize: 18.0,
          //                         ),
          //               ),
          //             ],
          //           ),
          //           Row(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Text(
          //                 FFLocalizations.of(context).getText(
          //                   'a14eq1e6' /* Delhi, IN */,
          //                 ),
          //                 style:
          //                     FlutterFlowTheme.of(context).titleLarge.override(
          //                           fontFamily: 'Sora',
          //                           color: FlutterFlowTheme.of(context)
          //                               .primaryBackground,
          //                           fontSize: 16.0,
          //                         ),
          //               ),
          //               Icon(
          //                 Icons.chevron_right_rounded,
          //                 color: FlutterFlowTheme.of(context).primaryBackground,
          //                 size: 24.0,
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 30.0, 0.0),
            child: Text(
              FFLocalizations.of(context).getText(
                'xdzk2szt' /* Change your location to connec... */,
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          // Builder(
          //   builder: (context) => Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
          //     child: InkWell(
          //       splashColor: Colors.transparent,
          //       focusColor: Colors.transparent,
          //       hoverColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       onTap: () async {
          //         logFirebaseEvent('SETTING_PAGE_materialList_Item_2_ON_TAP');
          //         logFirebaseEvent('materialList_Item_2_alert_dialog');
          //         await showAlignedDialog(
          //           context: context,
          //           isGlobal: true,
          //           avoidOverflow: false,
          //           targetAnchor: AlignmentDirectional(0.0, 0.0)
          //               .resolve(Directionality.of(context)),
          //           followerAnchor: AlignmentDirectional(0.0, 1.0)
          //               .resolve(Directionality.of(context)),
          //           builder: (dialogContext) {
          //             return Material(
          //               color: Colors.transparent,
          //               child: Container(
          //                 height: MediaQuery.sizeOf(context).height * 0.4,
          //                 width: double.infinity,
          //                 child: VideoAutoPlayComponentWidget(),
          //               ),
          //             );
          //           },
          //         ).then((value) => setState(() {}));
          //       },
          //       child: Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50.0),
          //           border: Border.all(
          //             color: Color(0x32000000),
          //             width: 0.7,
          //           ),
          //         ),
          //         child: Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
          //           child: Row(
          //             mainAxisSize: MainAxisSize.max,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 FFLocalizations.of(context).getText(
          //                   'nxhsfss5' /* Video autoplay settings */,
          //                 ),
          //                 style:
          //                     FlutterFlowTheme.of(context).titleLarge.override(
          //                           fontFamily: 'Sora',
          //                           fontSize: 18.0,
          //                         ),
          //               ),
          //               Row(
          //                 mainAxisSize: MainAxisSize.max,
          //                 children: [
          //                   Icon(
          //                     Icons.chevron_right_rounded,
          //                     color: FlutterFlowTheme.of(context).secondaryText,
          //                     size: 24.0,
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SETTING_PAGE_materialList_Item_2_ON_TAP');
                logFirebaseEvent('materialList_Item_2_navigate_to');

                context.pushNamed('NotificationSettings');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Color(0x32000000),
                    width: 0.7,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'mmtdate4' /* Notification Settings */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Sora',
                              fontSize: 18.0,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.chevron_right_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SETTING_PAGE_materialList_Item_2_ON_TAP');
                logFirebaseEvent('materialList_Item_2_navigate_to');

                context.pushNamed('ContactPage');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Color(0x32000000),
                    width: 0.7,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'ld5yw07j' /* Contact & FAQ */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Sora',
                              fontSize: 18.0,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.chevron_right_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 1.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SETTING_PAGE_materialList_Item_2_ON_TAP');
                logFirebaseEvent('materialList_Item_2_navigate_to');

                context.pushNamed('NotificationSettings');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Color(0x32000000),
                    width: 0.7,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'zq4trlob' /* Security & Privacy */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Sora',
                              fontSize: 18.0,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.chevron_right_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 12.0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('SETTING_PAGE_LOG_OUT_BTN_ON_TAP');
                logFirebaseEvent('Button_auth');
                GoRouter.of(context).prepareAuthEvent();
                await authManager.signOut();
                await SharesPrefs.clearUserData();
                GoRouter.of(context).clearRedirectLocation();
                context.goNamedAuth('MainAuth', context.mounted);
              },
              text: FFLocalizations.of(context).getText(
                'gs9ssvo9' /* Log Out */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0x6CE3E7ED),
                textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Color(0x00E3E7ED),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(30.0, 4.0, 30.0, 8.0),
          //   child: Text(
          //     FFLocalizations.of(context).getText(
          //       '7b20izuf' /* Follow us on */,
          //     ),
          //     style: FlutterFlowTheme.of(context).labelMedium,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       FlutterFlowIconButton(
          //         borderColor: FlutterFlowTheme.of(context).alternate,
          //         borderRadius: 12.0,
          //         borderWidth: 1.0,
          //         buttonSize: 48.0,
          //         fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          //         icon: FaIcon(
          //           FontAwesomeIcons.youtube,
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           size: 24.0,
          //         ),
          //         onPressed: () {
          //           print('IconButton pressed ...');
          //         },
          //       ),
          //       FlutterFlowIconButton(
          //         borderColor: FlutterFlowTheme.of(context).alternate,
          //         borderRadius: 12.0,
          //         borderWidth: 1.0,
          //         buttonSize: 48.0,
          //         fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          //         icon: FaIcon(
          //           FontAwesomeIcons.instagram,
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           size: 24.0,
          //         ),
          //         onPressed: () {
          //           print('IconButton pressed ...');
          //         },
          //       ),
          //       FlutterFlowIconButton(
          //         borderColor: FlutterFlowTheme.of(context).alternate,
          //         borderRadius: 12.0,
          //         borderWidth: 1.0,
          //         buttonSize: 48.0,
          //         fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          //         icon: FaIcon(
          //           FontAwesomeIcons.facebookF,
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           size: 24.0,
          //         ),
          //         onPressed: () {
          //           print('IconButton pressed ...');
          //         },
          //       ),
          //       FlutterFlowIconButton(
          //         borderColor: FlutterFlowTheme.of(context).alternate,
          //         borderRadius: 12.0,
          //         borderWidth: 1.0,
          //         buttonSize: 48.0,
          //         fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          //         icon: FaIcon(
          //           FontAwesomeIcons.linkedinIn,
          //           color: FlutterFlowTheme.of(context).secondaryText,
          //           size: 24.0,
          //         ),
          //         onPressed: () {
          //           print('IconButton pressed ...');
          //         },
          //       ),
          //     ].divide(SizedBox(width: 8.0)),
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 30.0, 4.0),
            child: Text(
              FFLocalizations.of(context).getText(
                '74cojc36' /* App Versions */,
              ),
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Sora',
                    fontSize: 18.0,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 4.0, 30.0, 20.0),
            child: Text(
              FFLocalizations.of(context).getText(
                'nrg7kc6d' /* v1.0.0 */,
              ),
              style: FlutterFlowTheme.of(context).labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
