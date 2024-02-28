import 'dart:async';

import 'package:dazel_dating_app/backend/Function.dart';
import 'package:dazel_dating_app/backend/models/user_data_model.dart';
import 'package:dazel_dating_app/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../backend/FetchRequest.dart';
import '../../backend/ServerFunctions.dart';
import '../../backend/firebase_analytics/analytics.dart';
import '../../backend/models/ChatsUsers.dart';
import '../../components/find_your_conversation_widget.dart';
import '../../components/matches_got_components_model.dart';
import '../../components/matches_got_components_widget.dart';
import '../../flutter_flow/flutter_flow_animations.dart';
import '../../flutter_flow/flutter_flow_model.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/internationalization.dart';
import '../chat_page/chat_page_widget.dart';
import 'main_home_model.dart';

class ChatsDisplayPage extends StatefulWidget {
  const ChatsDisplayPage({super.key});

  @override
  State<ChatsDisplayPage> createState() => _ChatsDisplayPageState();
}

class _ChatsDisplayPageState extends State<ChatsDisplayPage> {

  List<ChatsUsersModel> conversations = [];
  List<ChatsUsersModel> rawConversations = [];

  late MatchesGotComponentsModel matchesGotComponentsModel2;
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  bool isRecentChatAvailable = true;
  bool isNotSearching = true;
  late FindYourConversationModel findYourConversationModel;

  _fetchChats() async {
    Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      _fetchData();
    });
  }

  _fetchData() async {
    if (isNotSearching) {
      try {
        rawConversations = await fetchAllChats();
        conversations = rawConversations;
        setState(() {});
      } catch (e) {} finally {
        isRecentChatAvailable = rawConversations.isNotEmpty;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchesGotComponentsModel2 =
        createModel(context, () => MatchesGotComponentsModel());

    textController ??= TextEditingController();
    textFieldFocusNode ??= FocusNode();
    findYourConversationModel =
        createModel(context, () => FindYourConversationModel());

    _fetchData();
    _fetchChats();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    matchesGotComponentsModel2.dispose();
    textController?.dispose();

    textFieldFocusNode?.dispose();

    findYourConversationModel.dispose();

  }

  final animationsMap = {
    'containerOnPageLoadAnimation7': AnimationInfo(
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
    'containerOnPageLoadAnimation8': AnimationInfo(
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
    'textOnPageLoadAnimation': AnimationInfo(
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
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color:
        FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0.0, 10.0, 0.0, 10.0),
              child: wrapWithModel(
                // userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
                model: matchesGotComponentsModel2,
                updateCallback: () => setState(() {}),
                child: MatchesGotComponentsWidget(),
              ),
            ),
          ),
          if (isRecentChatAvailable) Align(
            alignment: AlignmentDirectional(-1.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  24.0, 10.0, 0.0, 10.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'vh6jglz8' /* Chat */,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context)
                    .titleMedium
                    .override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context)
                      .primaryText,
                ),
              ).animateOnPageLoad(
                  animationsMap['textOnPageLoadAnimation']!),
            ),
          ),
          if (!isRecentChatAvailable) SizedBox(height: 30,),
          if (isRecentChatAvailable) Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                10.0, 0.0, 10.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context)
                    .primaryBackground,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    8.0, 4.0, 8.0, 2.0),
                child: TextFormField(
                  controller: textController,
                  focusNode: textFieldFocusNode,
                  onChanged: (value) {
                    if (value!=null && value.isNotEmpty) {
                      isNotSearching = false;
                      conversations = rawConversations
                          .where((conversation) =>
                          conversation.name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                      setState(() {});
                    } else {
                      isNotSearching = true;
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText:
                    FFLocalizations.of(context).getText(
                      '7epueqjw' /* Search here... */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xFF979797),
                    ),
                    suffixIcon:
                        textController!.text.isNotEmpty
                        ? InkWell(
                      onTap: () async {
                        textController?.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color:
                        FlutterFlowTheme.of(context)
                            .secondaryText,
                        size: 20.0,
                      ),
                    )
                        : null,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  keyboardType: TextInputType.name,
                  validator: (value) {

                  },
                ),
              ),
            ).animateOnPageLoad(animationsMap[
            'containerOnPageLoadAnimation7']!),
          ),
          Container(
            decoration: BoxDecoration(),
            child: Visibility(
              visible: !isRecentChatAvailable,
              child: wrapWithModel(
                // userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
                model: findYourConversationModel,
                updateCallback: () => setState(() {}),
                child: FindYourConversationWidget(
                  text: "Find your conversations here",
                ),
              ),
            ),
          ),
          if (!isRecentChatAvailable)
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
          if (isRecentChatAvailable)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0.0, 0.0, 0.0, 20.0),
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'MAIN_HOME_PAGE_Container_4r2j43ic_ON_TAP');
                      logFirebaseEvent(
                          'Container_navigate_to');

                      var userMap = await Fetch.fetchUserDetails(
                        userId: conversations[i].receiverId
                      );

                      if (userMap['status']) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(
                          userModel: UserData.fromJson(userMap['data']),
                        )));
                      } else {
                        VxToast.show(context, msg: "Something went wrong please try after some time");
                      }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional
                                      .fromSTEB(10.0, 0.0,
                                      0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        100.0),
                                    child: Image.network(
                                      buildImageUrl(conversations[i].media[0]),
                                      width: 65.0,
                                      height: 65.0,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding:
                                  EdgeInsetsDirectional
                                      .fromSTEB(11.0, 0.0,
                                      0.0, 0.0),
                                  child: Column(
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        conversations[i].name,
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .titleMedium
                                            .override(
                                          fontFamily:
                                          'Inter',
                                          color: Colors
                                              .black,
                                        ),
                                      ),
                                      Text(
                                        conversations[i].mostRecentMessage['type'] == "text" ?
                                        conversations[i].mostRecentMessage['msg'] :
                                        conversations[i].mostRecentMessage['type'] == "image" ?
                                        "Image" :
                                        conversations[i].mostRecentMessage['type'] == "audio" ?
                                        "Audio Message" : conversations[i].mostRecentMessage['msg'],
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .bodyMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: Column(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  if (conversations[i].mostRecentMessageTime != null) Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0.0,
                                        0.0,
                                        0.0,
                                        5.0),
                                    child: Text(
                                      formatTimestamp(conversations[i].mostRecentMessageTime!),
                                      style:
                                      FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Inter',
                                        fontSize: 11.0,
                                        color: (conversations[i].unseenMessages != 0) ? FlutterFlowTheme.of(
                                            context)
                                            .primary : Color(0xFF979797),
                                      ),
                                    ),
                                  ),
                                  if (conversations[i].unseenMessages != 0) Container(
                                    width: 26.0,
                                    height: 26.0,
                                    decoration: BoxDecoration(
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .primary,
                                      borderRadius:
                                      BorderRadius
                                          .circular(12.0),
                                    ),
                                    child: Align(
                                      alignment:
                                      AlignmentDirectional(
                                          0.00, 0.00),
                                      child: Text(
                                        conversations[i].unseenMessages.toString(),
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily:
                                          'Inter',
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (conversations[i].unseenMessages == 0 && conversations[i].mostRecentMessage.toString().isEmpty) Container(
                                    decoration: BoxDecoration(
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .primary,
                                      borderRadius:
                                      BorderRadius
                                          .circular(12.0),
                                    ),
                                    child: Align(
                                      alignment:
                                      AlignmentDirectional(
                                          0.00, 0.00),
                                      child: Text(
                                        "New Match",
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily:
                                          'Inter',
                                          fontSize: 13.0,
                                        ),
                                      ).px(10).py(5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap[
                  'containerOnPageLoadAnimation8']!);
                },
                primary: false,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: conversations.length,
              ),
            ),
        ],
      ),
    );
  }
}
