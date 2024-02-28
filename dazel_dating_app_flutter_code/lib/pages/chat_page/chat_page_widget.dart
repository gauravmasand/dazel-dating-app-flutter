import 'dart:async';
import 'dart:io';

import 'package:dazel_dating_app/backend/Constants.dart';
import 'package:dazel_dating_app/backend/Function.dart';
import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:image_picker_plus/image_picker_plus.dart' as ipp;


import '../../backend/FetchRequest.dart';
import '../../backend/ServerFunctions.dart';
import '../../backend/models/ChatMessage.dart';
import '../../backend/models/user_data_model.dart';
import '/components/message_long_press_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_page_model.dart';
export 'chat_page_model.dart';


class ChatPageWidget extends StatefulWidget {
  UserData userModel;
  Map? data = {};
  ChatPageWidget({Key? key, required this.userModel, this.data}) : super(key: key);

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  late ChatPageModel _model;
  String onlineStatus = "";
  Timer? fetchChatTimer;
  final _channel = IOWebSocketChannel.connect('ws://${Constants.url}');

  bool isRecording = false;
  // String audioPath = "";
  // late AudioPlayer audioPlayer;


  List<ChatMessage> chatList = [];

  late String userId;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getOnlineStatus() async {
    await markMessagesAsSeen(widget.userModel.id);

    userId = await SharesPrefs.getValue("_id");
    onlineStatus = makeOnlineStatusFromString(await Fetch.getLastActiveStatus(widget.userModel.id));
    setState(() {});
  }

  void startWebSocket() {
    // Listen for incoming WebSocket messages (real-time updates)
    _channel.stream.listen((message) {
      // Handle incoming message (e.g., update chatList)
      // ...
    });
  }

  _fetchChat() {

    _fetch() async {

      List<ChatMessage> localChat = await ChatStorage.getChatMessages(
          widget.userModel.id);

      if (localChat.isEmpty) {
        Vx.log("fetched From server");
        // Fetch all chat messages from the server if not present locally
        chatList = (await Fetch.fetchChat(widget.userModel.id)).reversed.toList();
        ChatStorage.saveChatMessages(widget.userModel.id, chatList);
      } else {
        Vx.log("fetched From local");
        // Find the timestamp of the most recent chat locally
        String mostRecentTimestamp = localChat.first.timestamp;

        // Fetch only the new or updated chat messages from the server
        List<ChatMessage> newChat = (await Fetch.fetchChat(widget.userModel.id, sinceTimestamp: mostRecentTimestamp)).reversed.toList();

        Vx.log("fetched From local and from server " + newChat.toString());

        if (newChat.isNotEmpty) {
          Vx.log("fetched From local nothing new");
          localChat.insertAll(0, newChat);
          ChatStorage.saveChatMessages(widget.userModel.id, localChat);
        }

        // Use the locally stored chat messages
        chatList = localChat;
      }

      setState(() {});
    }

    // Set up a periodic timer to call _fetchChat every 0.1 seconds
    fetchChatTimer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      await _fetch();
    });

  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ChatPage'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    getOnlineStatus();

    startWebSocket();
    _fetchChat();


  }

  @override
  void dispose() {
    _model.dispose();
    fetchChatTimer?.cancel();
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          leading: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('CHAT_PAGE_PAGE_Container_7bu4qwd1_ON_TAP');
                logFirebaseEvent('Container_navigate_back');
                context.safePop();
              },
              child: Container(
                decoration: BoxDecoration(),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ),
          ),
          title: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('CHAT_PAGE_PAGE_Column_91n3j3ml_ON_TAP');
              logFirebaseEvent('Column_navigate_to');

              context.pushNamed('MainDiscoverPage');
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.userModel!.name!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      onlineStatus,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(7.0, 7.0, 15.0, 7.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('CHAT_CircleImage_k2ooscjl_ON_TAP');
                  logFirebaseEvent('CircleImage_navigate_to');

                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainDiscoverPageWidget(
                    model: widget.userModel,
                    isIndividualProfile: false,
                  )));

                },
                child: Container(
                  width: 55.0,
                  height: 55.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Hero(
                    tag: widget.userModel.id,
                    child: Image.network(
                      buildImageUrl(widget.userModel!.media![0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBtnText,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          itemCount: chatList.length,
                          itemBuilder: (_, i) {
                            Vx.log(chatList[i].message['type']);
                            return MessageItem(
                              chatList[i]
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 66,
                      maxHeight: MediaQuery.of(context).size.height*0.15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (!isRecording) Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              textCapitalization: TextCapitalization.none,
                              obscureText: false,
                              onChanged: (msg) {
                                _model.togglePinIconVisibility(msg.isEmpty);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                color: Colors.black,
                              ),
                              maxLines: null,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return;
                                }
                              },
                            ),

                          ),
                        ),
                        if (!isRecording) _model.showPinIcon ? Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                          child: IconButton(
                            onPressed: () async {

                              List<XFile> xFiles = await ImagePicker().pickMultiImage();

                              if (xFiles.isNotEmpty) {

                                List<File> files = [];

                                for (XFile xFile in xFiles) {
                                  File file = File(xFile.path);
                                  files.add(file);
                                }

                                Map message = {
                                  "msg" : "",
                                  "type" : 'image',
                                  "data" : "",
                                };

                                sendMessage(
                                  userId: userId,
                                  receiverId: widget.userModel.id, message: jsonEncode(message),
                                  files: files,
                                );

                                setState(() {});

                              }
                            },
                            icon: Icon(
                              Icons.attach_file,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        )
                            : Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 5.0, 0.0),
                          child: IconButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(source: ImageSource.camera);

                              if (pickedFile != null) {

                                Map message = {
                                  "msg" : "",
                                  "type" : 'image',
                                  "data" : "",
                                };
                                sendMessage(
                                  userId: userId,
                                  receiverId: widget.userModel.id, message: jsonEncode(message),
                                  files: [File(pickedFile.path)],
                                );
                                setState(() {});

                              }
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: !_model.showPinIcon ? Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: FlutterFlowTheme.of(context).primary,
                                    borderRadius: 20.0,
                                    borderWidth: 0.0,
                                    buttonSize: 35.0,
                                    fillColor: FlutterFlowTheme.of(context).primary,
                                    icon: FaIcon(
                                      FontAwesomeIcons.locationArrow,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    onPressed: () async {
                                      Map message = {
                                        "msg" : _model.textController.text,
                                        "type" : 'text',
                                        "data" : "",
                                      };
                                      sendMessage(userId: userId, receiverId: widget.userModel.id, message: jsonEncode(message));
                                      _model.textController.text = "";
                                      _model.togglePinIconVisibility(_model.textController.text.isEmpty);
                                      setState(() {});
                                    },
                                  ),
                                ) : Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 1.0, 0.0),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      isRecording = true;
                                    },
                                    onLongPressUp: () {
                                      isRecording = false;

                                    },

                                    child: AnimatedContainer(
                                      width: isRecording ? 100 : 31,
                                      duration: Duration(milliseconds: 200),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isRecording ? Colors.red : FlutterFlowTheme.of(context).primary,
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.microphoneAlt,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MessageItem(ChatMessage model) {

    if (model.message['type'] == "text") return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: !model.isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              10.0, 7.0, 10.0, 7.0),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width*0.8
            ),
            decoration: BoxDecoration(
              color: !model.isSender ? FlutterFlowTheme.of(context)

                  .primary : FlutterFlowTheme.of(context)
                  .accent2,
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(
                  20.0, 12.0, 20.0, 12.0),
              child: Text(
                model.message['msg'],
                style:
                FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                  fontFamily: 'Inter',
                  color: !model.isSender ? FlutterFlowTheme
                      .of(context)
                      .secondaryBackground : FlutterFlowTheme
                      .of(context)
                      .primaryText,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (model.message['type'] == "image" && model.isDoc) {
      if (model.docUrls.length == 1) return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                10.0, 7.0, 10.0, 7.0),
            child: Card(
              clipBehavior:
              Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context)
                  .secondaryBackground,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .secondary,
                  borderRadius:
                  BorderRadius.circular(20.0),
                ),
                alignment:
                AlignmentDirectional(1.00, 0.00),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(8.0),
                  child: Image.network(
                    buildChatMediaUrl(model.docUrls[0]),
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      if (model.docUrls.length == 2) return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                10.0, 7.0, 10.0, 7.0),
            child: Row(
              children: [
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondary,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                    ),
                    alignment:
                    AlignmentDirectional(1.00, 0.00),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                      child: Image.network(
                        buildChatMediaUrl(model.docUrls[0]),
                        width: 149.0,
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondary,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    alignment:
                    AlignmentDirectional(1.00, 0.00),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                      child: Image.network(
                        buildChatMediaUrl(model.docUrls[1]),
                        width: 149.0,
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      if (model.docUrls.length == 3) return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                10.0, 7.0, 10.0, 7.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[0]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[1]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondary,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                    ),
                    alignment:
                    AlignmentDirectional(1.00, 0.00),
                    child: ClipRRect(
                      child: Image.network(
                        buildChatMediaUrl(model.docUrls[2]),
                        width: 300.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      if (model.docUrls.length == 4) return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                10.0, 7.0, 10.0, 7.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[0]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[1]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[2]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondary,
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        alignment:
                        AlignmentDirectional(1.00, 0.00),
                        child: ClipRRect(
                          child: Image.network(
                            buildChatMediaUrl(model.docUrls[3]),
                            width: 149.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "writtenPrompt") {
      Map data = jsonDecode(model.message['data']);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: data['prompt'],
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w500 : FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 25, 0),
                      child: Text(
                        data['answer'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .primaryText : FlutterFlowTheme.of(context)
                              .secondaryBackground,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        "💬 "+model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "openingQuestion") {
      String data = jsonDecode(model.message['data']);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Opening Question...',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 25, 0),
                      child: Text(
                        data,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .primaryText : FlutterFlowTheme.of(context)
                              .secondaryBackground,

                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "typeOfDate") {
      String data = jsonDecode(model.message['data']);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'On your date preference...',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 25, 0),
                      child: Text(
                        data,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .primaryText : FlutterFlowTheme.of(context)
                              .secondaryBackground,

                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "bio") {
      String data = jsonDecode(model.message['data']);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Commented on your bio...',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 25, 0),
                      child: Text(
                        data,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .primaryText : FlutterFlowTheme.of(context)
                              .secondaryBackground,

                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "pic") {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Complemented on your profile pic',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "basics") {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Complemented on your basics...',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "moreAboutUser") {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Complemented on your info...',
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w400 : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    if (model.message['type'] == "interestIn" || model.message['type'] == "commonInterest") {
      List data = jsonDecode(model.message['data']);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: model.isSender ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor:
                        MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: model.message['type'] == "interestIn" ? "Complemented on your interest..." : "Complemented on common interest...",
                              style: TextStyle(
                                color: model.isSender ? FlutterFlowTheme.of(context)
                                    .primaryText : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontWeight: model.isSender ? FontWeight.w500 : FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: model.isSender ? FlutterFlowTheme.of(context)
                                .primaryText : FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: Wrap(
                        direction: Axis.horizontal,
                        clipBehavior: Clip.antiAlias,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        runSpacing: 0,
                        children: List.generate(
                          data.length,
                              (index) => InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Text_3udmt5nt_ON_TAP');
                              logFirebaseEvent('Text_navigate_to');

                              Navigator.push(context, MaterialPageRoute(builder: (context) => IntrestSelectionWidget()));
                            },

                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: model.isSender ? FlutterFlowTheme.of(context)
                                      .primary : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    data[index],
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      color:model.isSender ? FlutterFlowTheme.of(context)
                                          .secondaryBackground : FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: model.isSender ? FlutterFlowTheme.of(context).primary :  FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        "💬 "+model.message['msg'],
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lato',
                          color: model.isSender ? FlutterFlowTheme.of(context)
                              .secondaryBackground : FlutterFlowTheme.of(context)
                              .primaryText,

                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).px(10).py(5),
                    )
                  ].divide(SizedBox(height: 7)),
                ).py(25),
              ),
            ),
          ),
        ],
      );
    }

    // if (model.message['type'] == "video" && model.isDoc) return Row(
    //   mainAxisSize: MainAxisSize.max,
    //   mainAxisAlignment: model.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: EdgeInsetsDirectional.fromSTEB(
    //           10.0, 7.0, 10.0, 7.0),
    //       child: Card(
    //         clipBehavior:
    //         Clip.antiAliasWithSaveLayer,
    //         color: FlutterFlowTheme.of(context)
    //             .secondaryBackground,
    //         elevation: 4.0,
    //         shape: RoundedRectangleBorder(
    //           borderRadius:
    //           BorderRadius.circular(20.0),
    //         ),
    //         child: Container(
    //           width:
    //           MediaQuery.sizeOf(context).width *
    //               0.7,
    //           decoration: BoxDecoration(
    //             color: FlutterFlowTheme.of(context)
    //                 .primary,
    //             borderRadius:
    //             BorderRadius.circular(20.0),
    //           ),
    //           alignment:
    //           AlignmentDirectional(1.00, 0.00),
    //           child: FlutterFlowVideoPlayer(
    //             path:
    //             buildChatMediaUrl(model.docUrls[0]),
    //             videoType: VideoType.network,
    //             autoPlay: false,
    //             looping: false,
    //             showControls: false,
    //             allowFullScreen: false,
    //             allowPlaybackSpeedMenu: false,
    //             lazyLoad: true,
    //             pauseOnNavigate: false,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return SizedBox();
  }


}