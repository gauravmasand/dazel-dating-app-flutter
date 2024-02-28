import 'package:dazel_dating_app/backend/Function.dart';
import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/index.dart';
import 'package:velocity_x/velocity_x.dart';

import '../backend/FetchRequest.dart';
import '../backend/models/MatchUserModel.dart';
import '../pages/main_home/main_home_model.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'matches_got_components_model.dart';
export 'matches_got_components_model.dart';

class MatchesGotComponentsWidget extends StatefulWidget {
  const MatchesGotComponentsWidget({Key? key}) : super(key: key);

  @override
  MatchesGotComponentsWidgetState createState() =>
      MatchesGotComponentsWidgetState();
}

class MatchesGotComponentsWidgetState extends State<MatchesGotComponentsWidget>
    with TickerProviderStateMixin {
  late MatchesGotComponentsModel _model;
  List<MatchedUserModel> matches = [];
  List<bool> isUserIdInList = [];

  _fetchMatchUser() async {
    matches = await Fetch.fetchMatchedUsers();
    for (var match in matches) {
      bool flag = await SharesPrefs.isUserIdInMatchesList(match.id);
      isUserIdInList.add(flag);
    }
    final reorderedMatches = <MatchedUserModel>[];
    final reorderedIsUserIdInList = <bool>[];

    for (int i = 0; i < matches.length; i++) {
      if (isUserIdInList[i]) {
        reorderedMatches.insert(0, matches[i]);
        reorderedIsUserIdInList.insert(0, true);
      } else {
        reorderedMatches.add(matches[i]);
        reorderedIsUserIdInList.add(false);
      }
    }

    matches = reorderedMatches.reversed.toList();
    isUserIdInList = reorderedIsUserIdInList.reversed.toList();
    setState(() { });
  }

  void reorderMatchesList() {

  }

  _getMatchViewed() async {
    var data = await SharesPrefs.getMatchesList();
    Vx.log("matches data is " + data.toString());
  }

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0.0, 40.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0.8, 0.8),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0.0, 40.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(0.8, 0.8),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    // _model = MatchesGotComponentsModel();
    _model = createModel(context, () => MatchesGotComponentsModel());

    _fetchMatchUser();
    _getMatchViewed();

  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(-1.00, 0.00),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 0.0, 10.0),
            child: Text(
              'Match Queue',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
          ),
        ),
        if (matches.isNotEmpty)
          Container(
            width: double.infinity,
            height: 130.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: matches.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                return Row(
                  children: [
                    MatchItem(i, matches[i]),
                    SizedBox(width: 10.0)
                  ],
                );
              },
            ),
          ),
        if (matches.isEmpty)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/450/600',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.63,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: Text(
                              "Hey, Keep swiping you have a nice profile definitely you will get match😉",
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: InkWell(
                              onTap: () {

                                setState(() {
                                  MainHomeModel.tabBarController!.animateTo(
                                    2,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                });

                                // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingWidget()));
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '1ysluktx' /* Get Started! */,
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
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
      ],
    );
  }

  Widget MatchItem(i, MatchedUserModel model) {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          logFirebaseEvent('MATCHES_GOT_COMPONENTS_Container_l8vuzbm');
          logFirebaseEvent('Container_navigate_to');
          Navigator.push(context, MaterialPageRoute(builder: (context) => GotMatchWidget(id: model.id, name: model.name, media: model.media)));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                !isUserIdInList[i] ? FlutterFlowTheme.of(context).primary : Colors.grey.withOpacity(0.5),
                !isUserIdInList[i] ? FlutterFlowTheme.of(context).secondary : Colors.grey.withOpacity(0.3),
              ],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.circular(200.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(200.0),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      buildImageUrl(model.media[0]),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            color: Colors.grey[500],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!);
  }


}
