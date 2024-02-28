import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'profile_strength_model.dart';
export 'profile_strength_model.dart';

class ProfileStrengthWidget extends StatefulWidget {
  const ProfileStrengthWidget({Key? key}) : super(key: key);

  @override
  _ProfileStrengthWidgetState createState() => _ProfileStrengthWidgetState();
}

class _ProfileStrengthWidgetState extends State<ProfileStrengthWidget> {
  late ProfileStrengthModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileStrengthModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ProfileStrength'});
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
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'PROFILE_STRENGTH_arrow_back_rounded_ICN_');
                          logFirebaseEvent('IconButton_navigate_back');
                          context.safePop();
                        },
                      ),
                    ]
                        .divide(SizedBox(width: 20.0))
                        .around(SizedBox(width: 20.0)),
                  ),
                ),
                CircularPercentIndicator(
                  percent: 0.39,
                  radius: 50.0,
                  lineWidth: 5.0,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: FlutterFlowTheme.of(context).secondary,
                  backgroundColor: FlutterFlowTheme.of(context).accent4,
                  center: Text(
                    FFLocalizations.of(context).getText(
                      'zfo3lps1' /* 39% */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'ba19aa4r' /* Your profile has potential😉 */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 8.0, 30.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '1pk69fs9' /* Fantastic progress! Keep enric... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 0.0),
                  child: GridView(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75
                    ),
                    children: [
                      Item(
                        path: "assets/images/pngtree-lovely-couple-couple-dating-lovely-date-dating-couple-png-image_3785362-removebg-preview.png",
                        title: FFLocalizations.of(context).getText(
                          '9509rz73' /* Looking for */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'sy6mcrzy' /* Short Term Fun */,
                        ),
                      ),
                      Item(
                        path: "assets/images/icons8-notes-500.png",
                        title: FFLocalizations.of(context).getText(
                          'o60hlp3b' /* Bio */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'emr1ucl4' /* Not Written */,
                        )
                      ),
                      Item(
                        path: "assets/images/icons8-interest-96.png",
                        title: FFLocalizations.of(context).getText(
                          '8a5bbmq0' /* Interests */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'r5yqqyed' /* 3 of 5 added */,
                        )
                      ),
                      Item(
                        path: "assets/images/icons8-verified-96.png",
                        title: FFLocalizations.of(context).getText(
                        '4syl7una' /* Verify profile */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'x50ty2w7' /* Not verified */,
                        ),
                      ),
                      Item(
                        path: "assets/images/icons8-enjoy-96.png",
                        title: FFLocalizations.of(context).getText(
                          '6omzuwqk' /* Basic Info */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'azcmk0xk' /* 2 of 5 added */,
                        ),
                      ),
                      Item(
                        path: "assets/images/icons8-playing-card-on-special-occasion-of-new-year---featuring-hearts-56.png",
                        title: FFLocalizations.of(context).getText(
                        'ouc0638o' /* More about u */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                        'a81aycbr' /* 8 of 9 added */,
                        ),
                      ),
                      Item(
                        path: "assets/images/icons8-media-96.png",
                        title: FFLocalizations.of(context).getText(
                          'a8uvbbae' /* Media */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'g558umze' /* 2 of 5 added */,
                        ),
                      ),
                      Item(
                        path: "assets/images/fast-food.png",
                        title: "Food Prefs",
                        desc: FFLocalizations.of(context).getText(
                          '75wdoxkr' /* 1 of 3 added */,
                        )
                      ),
                      Item(
                        path: "assets/images/icons8-dating-app-96_(1).png",
                        title: FFLocalizations.of(context).getText(
                          'octrifpa' /* Prompts */,
                        ),
                        desc: FFLocalizations.of(context).getText(
                          'ox853nrl' /* 0 of 3 added */,
                        )
                      ),
                      Item(
                        path: "assets/images/instagram_logo_2022_freelogovectors.net_.webp",
                        title: FFLocalizations.of(context).getText('3wurrrx7' /* Instagram */,),
                        desc: FFLocalizations.of(context).getText('wtrh53td' /* Not connected */,)
                      ),
                      Item(
                        path: "assets/images/spotify_(1).png",
                        title: FFLocalizations.of(context).getText('5scn0r52' /* Spotify */,),
                        desc: FFLocalizations.of(context).getText('bl6ycwua' /* Not connected */,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Item({required String path, required String title, required String desc}) {
    return Container(
      // height: 210.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
            .primaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0x68677681),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0.0, 20.0, 0.0, 0.0),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(8.0),
              child: Image.asset(
                path,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0.0, 5.0, 0.0, 0.0),
            child: Text(
              title,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(
                fontFamily: 'Inter',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0.0, 5.0, 0.0, 15.0),
            child: Text(
              desc,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(
                fontFamily: 'Inter',
                color:
                FlutterFlowTheme.of(context)
                    .secondaryText,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
