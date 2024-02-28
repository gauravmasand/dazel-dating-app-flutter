import 'package:dazel_dating_app/backend/FetchRequest.dart';
import 'package:dazel_dating_app/backend/Function.dart';
import 'package:dazel_dating_app/backend/models/user_data_model.dart';
import 'package:dazel_dating_app/flutter_flow/flutter_flow_animations.dart';
import 'package:dazel_dating_app/flutter_flow/flutter_flow_util.dart';
import 'package:dazel_dating_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../backend/Constants.dart';
import '../../backend/firebase_analytics/analytics.dart';
import '../../backend/models/GotRightSwipeUserModel.dart';
import '../../components/find_your_conversation_widget.dart';
import '../../components/matches_got_components_widget.dart';
import '../../flutter_flow/flutter_flow_model.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/internationalization.dart';
import 'main_home_model.dart';

class GotLikes extends StatefulWidget {
  const GotLikes({super.key});

  @override
  State<GotLikes> createState() => _GotLikesState();
}

class _GotLikesState extends State<GotLikes> {

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
  };
  List<GotRightSwipeUserModel> users = [];
  bool noLikes = false;
  late FindYourConversationModel findYourConversationModel;

  _fetchRightSwipeUsers() async {
    users = [];
    users = await Fetch.fetchGotRightSwipeUsers();
    noLikes = users.isEmpty;
  }

  @override
  void initState() {
    super.initState();
    findYourConversationModel =
        createModel(context, () => FindYourConversationModel());

    _fetchRightSwipeUsers();

  }

  @override
  void dispose() {
    super.dispose();
    findYourConversationModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _fetchRightSwipeUsers();
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: MatchesGotComponentsWidget(),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Color(0x39677681),
            ),
            if (!noLikes)
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 0.0, 10.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'cbc4lpy2' /* Who liked you */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ),
              ),
            !noLikes ? Container(
              child: users.isNotEmpty ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: MasonryGridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    return whoLikedYouItem(index: i, model: users[i]);
                  },
                ),
              ) : Center(child: CircularProgressIndicator()).py(100),
            ) : NoLikesThere(),
          ],
        ),
      ),
    );
  }

  Widget whoLikedYouItem({index, required GotRightSwipeUserModel model}) {
    Vx.log(model.message);
    var parentData = model.message;
    late var data;
    if (parentData!['type'] != 'swipe') {
      data = jsonDecode(parentData['data']);
    }
    return Padding(
      padding:
      EdgeInsetsDirectional.fromSTEB(
          0.0, index == 1 ? 50.0 : 0.0, 0.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          logFirebaseEvent(
              'MAIN_HOME_PAGE_Container_js5dvcmx_ON_TAP');
          logFirebaseEvent(
              'Container_navigate_to');

          Map<String, dynamic> data = await Fetch.fetchUserDetails(userId: model.id);
          if (data['status'] == false) {
            return;
          }
          Map<String, dynamic> userData = data['data'];
          Vx.log(userData);
          UserData userModel = UserData.fromJson(userData);

          Constants.messageOnLike = model.message!;

          Navigator.push(context, MaterialPageRoute(builder: (context) => MainDiscoverPageWidget(model: userModel, isIndividualProfile: false,)));

        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                color: Color(0xFFE7E5FD),
                borderRadius:
                BorderRadius.circular(24.0),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: model.id,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                          24.0),
                      child: Image.network(
                        buildImageUrl(model.media[0]),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        alignment:
                        Alignment(0.50, 0.00),
                      ),
                    ),
                  ),
                  Align(
                    alignment:
                    AlignmentDirectional(
                        0.00, 1.00),
                    child: Container(
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        gradient:
                        LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent
                          ],
                          stops: [0.0, 1.0],
                          begin:
                          AlignmentDirectional(
                              0.0, 1.0),
                          end:
                          AlignmentDirectional(
                              0, -1.0),
                        ),
                        borderRadius:
                        BorderRadius.only(
                          bottomLeft:
                          Radius.circular(
                              24.0),
                          bottomRight:
                          Radius.circular(
                              24.0),
                          topLeft:
                          Radius.circular(
                              0.0),
                          topRight:
                          Radius.circular(
                              0.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment:
                    AlignmentDirectional(
                        0.00, 1.00),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: Row(
                        mainAxisSize:
                        MainAxisSize.max,
                        children: [
                          SizedBox(width: 10,),
                          if (model.isOnline) Align(
                            alignment:
                            AlignmentDirectional(
                                -1.00,
                                1.00),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  8.0,
                                  0.0,
                                  0.0,
                                  27.0),
                              child: Icon(
                                Icons
                                    .circle_rounded,
                                color: Color(
                                    0xFF45D657),
                                size: 10.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                            AlignmentDirectional(
                                -1.00,
                                1.00),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  5.0,
                                  16.0,
                                  12.0,
                                  20.0),
                              child:
                              SelectionArea(
                                  child:
                                  Text(
                                    "${model.name}, ${calculateAge(model.dob)}",
                                    textAlign:
                                    TextAlign
                                        .start,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .headlineLarge
                                        .override(
                                      fontFamily:
                                      'Sora',
                                      color: FlutterFlowTheme.of(
                                          context)
                                          .primaryBackground,
                                      fontSize:
                                      16.0,
                                      fontWeight:
                                      FontWeight
                                          .w500,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            if (parentData!['type'] != 'swipe') Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      if (model.message?['type'] == 'pic') Text(
                        "Complemented in pics",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'writtenPrompt') Text(
                        "${data?['prompt']} ${data?['answer']}",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'typeOfDate') Text(
                        "Type of Date... ${data}",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'openingQuestion') Text(
                        "Opening Question... ${data}",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'bio') Text(
                        "Bio... ${data}",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'basics') Text(
                        "Complemented on your basics info",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'moreAboutUser') Text(
                        "Complemented on your more info",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'interestIn') Text(
                        "Complemented on your interest",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                      if (model.message?['type'] == 'commonInterest') Text(
                        "Complemented on your more info",
                        textAlign:
                        TextAlign
                            .start,
                        style: FlutterFlowTheme.of(
                            context)
                            .headlineLarge
                            .override(
                          fontFamily:
                          'Sora',
                          color: FlutterFlowTheme.of(
                              context)
                              .primaryText,
                          fontSize:
                          14.0,
                          fontWeight:
                          FontWeight
                              .w300,
                        ),
                      ),
                    ],
                  ).px(20),

                  if (model.message?['type'] == 'interestIn' || model.message?['type'] == 'commonInterest') SizedBox(height: 4,),
                  if (model.message?['type'] == 'interestIn' || model.message?['type'] == 'commonInterest') Container(
                    height: 40, // Set the height as needed
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            logFirebaseEvent('EDIT_PROFILE_PAGE_Text_3udmt5nt_ON_TAP');
                            logFirebaseEvent('Text_navigate_to');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IntrestSelectionWidget(),
                              ),
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 7, 10, 7),
                                child: Text(
                                  data?[index],
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 6,),

                  Text(
                    "💬 ${model.message?['msg']}",
                    textAlign:
                    TextAlign
                        .start,
                    style: FlutterFlowTheme.of(
                        context)
                        .headlineLarge
                        .override(
                      fontFamily:
                      'Sora',
                      color: FlutterFlowTheme.of(
                          context)
                          .primaryText,
                      fontSize:
                      16.0,
                      fontWeight:
                      FontWeight
                          .w500,
                    ),
                  ).px(20),
                ],
              ),
            )
          ],
        ),
      ).animateOnPageLoad(animationsMap[
      'containerOnPageLoadAnimation1']!),
    );
  }

  Widget NoLikesThere() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(),
          child: wrapWithModel(
            model: findYourConversationModel,
            updateCallback: () => setState(() {}),
            child: FindYourConversationWidget(
              text: "Hey, Dazel still like you",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              100.0, 5.0, 100.0, 0.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent(
                  'MAIN_HOME_PAGE_Container_2n5fek7z_ON_TAP');
              logFirebaseEvent('Container_tab_bar');
              setState(() {
                MainHomeModel.tabBarController!.animateTo(
                  2,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              });
            },
            child: Container(
              width:
              MediaQuery.sizeOf(context).width * 0.5,
              decoration: BoxDecoration(
                color:
                FlutterFlowTheme.of(context).primary,
                borderRadius:
                BorderRadius.circular(100.0),
              ),
              child: Align(
                alignment:
                AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      15.0, 15.0, 15.0, 15.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'ekk5dd23' /* Keep Swiping */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context)
                        .bodyMedium
                        .override(
                      fontFamily: 'Inter',
                      color:
                      FlutterFlowTheme.of(context)
                          .info,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
