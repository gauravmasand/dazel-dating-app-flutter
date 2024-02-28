import 'dart:ui';

import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/backend/ServerFunctions.dart';
import 'package:dazel_dating_app/backend/SwipeUser.dart';
import 'package:dazel_dating_app/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../backend/Constants.dart';
import '../backend/Function.dart';
import '../backend/models/user_data_model.dart';
import '/components/complement_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'show_profile_model.dart';
export 'show_profile_model.dart';

class ShowProfileWidget extends StatefulWidget {
  ShowProfileWidget({
    Key? key,
    required this.userModel,
    required this.icon,
    required this.color,
    required this.isIndividualProfile,
  }) : super(key: key);

  UserData userModel;
  Widget? icon;
  Color? color;
  bool isIndividualProfile;

  @override
  ShowProfileWidgetState createState() => ShowProfileWidgetState();
}

class ShowProfileWidgetState extends State<ShowProfileWidget> {

  // State field(s) for PageView widget.
    PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
      pageViewController1!.hasClients &&
      pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
      pageViewController2!.hasClients &&
      pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;

  late ShowProfileModel _model;
  late ScrollController scrollController;
  double _offset = 0.0;

  List<Widget> aboutTheUser = [];

  List<String> commonInterests = [];
  Map<String, dynamic> userData = {};

  int aboutDetailsCount = 0;

  String heightString = '';

  getCommonInterest() async {
    List userInterest = await SharesPrefs.getValue('interests');
    setState(() {
      commonInterests = userData['interests'].where((interest) => userInterest.contains(interest)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowProfileModel());
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

    fetchUserData().then((Map<String, dynamic>? userData) {
      if (userData != null) {
        this.userData = userData;
        buildAboutUserItems();

        Vx.log("User data is " + this.userData.toString());

        setState(() { });
      } else {
        // Handle the case where user data is not available
      }
    });
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    return widget.userModel.toJson();
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  void _scrollListener() {
    setState(() {
      _offset = scrollController.offset;
      // print("The Offset is ${_offset}");
      // Add your logic here based on the scroll offset
      // For instance, perform actions when reaching certain positions
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildAboutTheUser();
    buildAboutUserItems();
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0,),
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {

                    if (widget.icon == Icon(
                      Icons.arrow_back_ios_rounded,
                      color: FlutterFlowTheme.of(context).secondary,
                    )) {
                      logFirebaseEvent('SHOW_PROFILE_COMP_Icon_iqozi47x_ON_TAP');
                      logFirebaseEvent('Icon_navigate_back');
                      Navigator.pop(context);
                    } else {
                      MainHomeWidget.controller.undo();
                    }

                  },
                  child: widget.icon!,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.userModel!.name!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                            child: FaIcon(
                              Icons.person_4_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16,
                            ),
                          ),
                          Text(
                            "${calculateAge(widget.userModel!.dob!)} yo",
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'TT Firs Neue Bold',
                              fontWeight: FontWeight.w800,
                              useGoogleFonts: false,
                            ),
                          ),
                        ].divide(SizedBox(width: 3)),
                      ),
                      if (widget.userModel!.latitude!.isNotEmpty && widget.userModel!.longitude!.isNotEmpty)
                        Row(
                        mainAxisSize: MainAxisSize.max,//20.937425 //77.779549
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                            child: FaIcon(
                              FontAwesomeIcons.locationArrow,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16,
                            ),
                          ),
                          Text(

                               "${calculateDistance(Constants.latitude, Constants.longitude, double.parse(widget.userModel!.latitude!), double.parse(widget.userModel!.longitude!)).toStringAsFixed(0)} km away",
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'TT Firs Neue Bold',
                              fontWeight: FontWeight.w800,
                              useGoogleFonts: false,
                            ),
                          ),
                        ].divide(SizedBox(width: 3)),
                      ),
                    ].divide(SizedBox(width: 5)),
                  ),
                ].divide(SizedBox(height: 2)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 100,
            height: _offset <= 20 ? MediaQuery.of(context).size.height-200 : 450,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_offset > 20 && widget.userModel!.openingQuestions!.isNotEmpty) Align(
                                alignment: AlignmentDirectional(0.00, -1.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 5),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SHOW_PROFILE_COMP_Image_k9hm04jm_ON_TAP');
                                        logFirebaseEvent('Image_alert_dialog');

                                        if (widget.isIndividualProfile) {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                        } else {
                                          await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(0, 0)
                                              .resolve(Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(0, 1)
                                              .resolve(Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                child: ComplementComponentWidget(
                                                  userData: widget.userModel,
                                                  userId: widget.userModel.id,
                                                  complementOn: 'openingQuestion',
                                                  data: widget.userModel.openingQuestions[0],
                                                ),
                                              ),
                                            );
                                          },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Ink(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Align(
                                          alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                          child: Text(
                                            widget.userModel!.openingQuestions![0],
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                              fontFamily: 'Inter',
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.00, 1.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 0, 30, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.00, 0.00),
                                        child: InkWell(
                                          onTap: () {
                                            swipeLeft(widget.userModel.id);
                                            updateAcceptStatus(widget.userModel.id, false);
                                            if (widget.isIndividualProfile) {
                                              Navigator.pop(context);
                                            } else {
                                              MainHomeWidget.controller.swipeLeft();
                                            }
                                          },
                                          child: Card(
                                            clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(200),
                                            ),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(1000),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(13, 13, 13, 13),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    'assets/images/x-mark.png',
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.00, 0.00),
                                        child: InkWell(
                                          onTap: () async {
                                            String result = await swipeRight(otherUserId: widget.userModel.id) as String;
                                            if (!widget.isIndividualProfile) {
                                              updateAcceptStatus(widget.userModel.id, true);
                                              String id  = await SharesPrefs.getValue('_id');
                                              if (Constants.messageOnLike['data'] != "") {
                                                // await sendMessage(userId: widget.userModel
                                                //     .id,
                                                //     receiverId: id,
                                                //     message: jsonEncode(
                                                //         Constants
                                                //             .messageOnLike));
                                              }
                                              context.safePop();
                                              Constants.messageOnLike = {};
                                              setState(() {});
                                            }
                                            if (result == "Right swipe successful. It's a match!") {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => GotMatchWidget(
                                                id: widget.userModel.id,
                                                media: widget.userModel.media!,
                                                name: widget.userModel.name!,
                                              )));
                                            }
                                            MainHomeWidget.controller.swipeRight();
                                          },
                                          child: Card(
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(200),
                                            ),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFE2C7A),
                                                borderRadius: BorderRadius.circular(1000),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 18, 15, 15),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    'assets/images/heart_(1).png',
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.00, 0.00),
                                        child: Builder(
                                          builder: (context) => InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'SHOW_PROFILE_COMP_Card_saknqx58_ON_TAP');
                                              logFirebaseEvent(
                                                  'Card_alert_dialog');

                                              if (widget.isIndividualProfile) {

                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                              } else {
                                                await showAlignedDialog(
                                                  context: context,
                                                  isGlobal: true,
                                                  avoidOverflow: false,
                                                  targetAnchor:
                                                  AlignmentDirectional(0, 0)
                                                      .resolve(
                                                      Directionality.of(
                                                          context)),
                                                  followerAnchor:
                                                  AlignmentDirectional(0, 1)
                                                      .resolve(
                                                      Directionality.of(
                                                          context)),
                                                  builder: (dialogContext) {
                                                    return Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: ComplementComponentWidget(
                                                          userId: widget
                                                              .userModel.id,
                                                          complementOn: 'pic',
                                                          data: widget.userModel
                                                              .media,
                                                          userData: widget.userModel,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    setState(() {}));
                                              }
                                            },
                                            child: Card(
                                              clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(200),
                                              ),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      1000),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(13, 13, 13, 13),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                    child: Image.asset(
                                                      'assets/images/chat_(3).png',
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20))
                                        .addToStart(SizedBox(width: 20))
                                        .addToEnd(SizedBox(width: 20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: double.infinity,
                    height: _offset <= 20 ? MediaQuery.of(context).size.height-300 :
                    (widget.userModel!.openingQuestions!.isNotEmpty ? 290 : 370),
                    decoration: BoxDecoration(),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsetsDirectional.fromSTEB(0, _offset <= 20 ? 0 : 20, 0, 0),
                      child: ListView.builder(
                        physics: _offset <= 20 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                        itemBuilder: (_, i) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsetsDirectional.fromSTEB((i == 0 && _offset <= 20) ? 0 : 20, 0, 0, _offset <= 20 ? 0 : 10),
                            child: Card (
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(_offset <= 20 ? 20 : 15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(_offset <= 20 ? 20 : 15),
                                child: AnimatedContainer(
                                  width: _offset <= 20 ? MediaQuery.of(context).size.width-20 : 225,
                                  duration: Duration(milliseconds: 200),
                                  child: Hero(
                                    tag: widget.userModel!.id!,
                                    child: Image.network(
                                      buildImageUrl(widget.userModel!.media![i]),
                                      width: double.infinity,
                                      height: _offset <= 20 ? MediaQuery.of(context).size.height*0.8 : 225,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0,),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _offset <= 20 ? 1 : widget.userModel!.media!.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (commonInterests.isNotEmpty) Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25, 20, 25, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'tp2bae3j' /* Common Interest In */,
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'SHOW_PROFILE_COMP_Image_fsd31s24_ON_TAP');
                                logFirebaseEvent('Image_alert_dialog');

                                if (widget.isIndividualProfile) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                } else {
                                  await showAlignedDialog(
                                    context: context,
                                    isGlobal: true,
                                    avoidOverflow: false,
                                    targetAnchor: AlignmentDirectional(0, 0)
                                        .resolve(Directionality.of(context)),
                                    followerAnchor: AlignmentDirectional(0, 1)
                                        .resolve(Directionality.of(context)),
                                    builder: (dialogContext) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: double.infinity,
                                          child: ComplementComponentWidget(
                                            userId: widget.userModel.id,
                                            complementOn: 'commonInterest',
                                            data: commonInterests,
                                            userData: widget.userModel
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/customer-satisfaction.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 8.0, // Adjust the spacing between items as needed
                        runSpacing: 8.0, // Adjust the run spacing as needed
                        children: List.generate(
                          commonInterests.length,
                              (i) => InkWell(
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
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  commonInterests[i],
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
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 4)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25, 20, 25, 25),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Builder(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'SHOW_PROFILE_Container_8y6n6kbk_ON_TAP');
                      logFirebaseEvent('Container_alert_dialog');

                      if (widget.isIndividualProfile) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                      } else {
                        await showAlignedDialog(
                          context: context,
                          isGlobal: true,
                          avoidOverflow: false,
                          targetAnchor: AlignmentDirectional(0, 0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(0, 1)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                child: ComplementComponentWidget(
                                  userData: widget.userModel,
                                  userId: widget.userModel.id,
                                  complementOn: 'typeOfDate',
                                  data: widget.userModel.typeOfDate,
                                ),
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      }
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.67,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.userModel!.typeOfDate!.replaceAll('\n', ' '),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Lato',
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.solidComments,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 16,
                          ),
                        ].divide(SizedBox(width: 10)),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.userModel!.writtenPrompts!.isNotEmpty) Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              height: 300,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                height: 500,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                      child: PageView.builder(
                        itemBuilder: (_, i) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25, 0, 0, 0),
                                  child: RichText(
                                    textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: widget.userModel!.writtenPrompts![i].prompt,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25, 0, 25, 0),
                                child: Text(
                                  widget.userModel!.writtenPrompts![i].answer,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 10, 25, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'SHOW_PROFILE_COMP_Image_d78c2odo_ON_TAP');
                                      logFirebaseEvent('Image_alert_dialog');

                                      if (widget.isIndividualProfile) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                      } else {
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(0, 0)
                                              .resolve(
                                              Directionality.of(context)),
                                          followerAnchor:
                                          AlignmentDirectional(0, 1).resolve(
                                              Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                child:
                                                ComplementComponentWidget(
                                                  userData: widget.userModel,
                                                  userId: widget.userModel.id,
                                                  complementOn: 'writtenPrompt',
                                                  data: widget.userModel.writtenPrompts?[i],
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/customer-satisfaction.png',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 5)),
                          );
                        },
                        itemCount: userData['writtenPrompts'].length,
                        controller: pageViewController1 ??=
                            PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.00, 1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
                        child: SmoothPageIndicator(
                          controller: pageViewController1 ??=
                              PageController(initialPage: 0),
                          count: widget.userModel!.writtenPrompts!.length,
                          axisDirection: Axis.horizontal,
                          onDotClicked: (i) async {
                            await pageViewController1!.animateToPage(
                              i,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          effect: ExpandingDotsEffect(
                            expansionFactor: 3,
                            spacing: 8,
                            radius: 16,
                            dotWidth: 16,
                            dotHeight: 8,
                            dotColor: FlutterFlowTheme.of(context).accent1,
                            activeDotColor:
                            FlutterFlowTheme.of(context).primary,
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.userModel!.openingQuestions!.isNotEmpty) Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 20),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: userData['name'],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                'zyn4d1va' /* ,  */,
                              ),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                'ksw5phwn' /* Asked */,
                              ),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
                    child: Text(
                      widget.userModel!.openingQuestions![0],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 25, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'SHOW_PROFILE_COMP_Image_k9hm04jm_ON_TAP');
                          logFirebaseEvent('Image_alert_dialog');

                          if (widget.isIndividualProfile) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                          } else {
                            await showAlignedDialog(
                              context: context,
                              isGlobal: true,
                              avoidOverflow: false,
                              targetAnchor: AlignmentDirectional(0, 0)
                                  .resolve(Directionality.of(context)),
                              followerAnchor: AlignmentDirectional(0, 1)
                                  .resolve(Directionality.of(context)),
                              builder: (dialogContext) {
                                return Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: double.infinity,
                                    child: ComplementComponentWidget(
                                      userData: widget.userModel,
                                      userId: widget.userModel.id,
                                      complementOn: 'openingQuestion',
                                      data: widget.userModel.openingQuestions[0],
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/customer-satisfaction.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 5))
                    .addToStart(SizedBox(height: 25))
                    .addToEnd(SizedBox(height: 25)),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
          child: Text(
            "About ${widget.userModel.gender=="Men" ? "his" : "her"}",
            style: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: 'Inter',
              color: FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (aboutTheUser.length != 0) Container(
          width: double.infinity,
          height: 400,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: PageView.builder(
                  itemCount: aboutTheUser.length,
                  itemBuilder: (_, i) {
                    return aboutTheUser[i];
                  },
                  controller: pageViewController2 ??= PageController(initialPage: 0),
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.85, -0.8),
                child: SmoothPageIndicator(
                  controller: pageViewController2 ??= PageController(initialPage: 0),
                  count: aboutTheUser.length,
                  axisDirection: Axis.vertical,
                  onDotClicked: (i) async {
                    await pageViewController2!.animateToPage(
                      i,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  effect: ExpandingDotsEffect(
                    expansionFactor: 3,
                    spacing: 8,
                    radius: 16,
                    dotWidth: 16,
                    dotHeight: 8,
                    dotColor: FlutterFlowTheme.of(context).accent1,
                    activeDotColor: FlutterFlowTheme.of(context).primary,
                    paintStyle: PaintingStyle.stroke,
                  ),
                ),
              ),
            ],
          ),
        ),
      ].divide(SizedBox(height: 5)),
    );
  }

  List<List<String>> chunkList(List<String> list, int chunkSize) {
    List<List<String>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }
  
  buildAboutTheUser() {

    List<Widget> tempAboutList = [];

    if (widget.userModel.interests!.isNotEmpty) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color:
              FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30, 0, 10, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'j2c7rytl' /* Interested in */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color:
                                FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) => Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 25, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'SHOW_PROFILE_COMP_Image_xt0j2zbc_ON_TAP');
                                  logFirebaseEvent(
                                      'Image_alert_dialog');

                                  if (widget.isIndividualProfile) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                  } else {
                                    await showAlignedDialog(
                                      context: context,
                                      isGlobal: true,
                                      avoidOverflow: false,
                                      targetAnchor:
                                      AlignmentDirectional(0, 0)
                                          .resolve(
                                          Directionality.of(
                                              context)),
                                      followerAnchor:
                                      AlignmentDirectional(0, 1)
                                          .resolve(
                                          Directionality.of(
                                              context)),
                                      builder: (dialogContext) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: double.infinity,
                                            child: ComplementComponentWidget(
                                              userId: widget.userModel.id,
                                              userData: widget.userModel,
                                              complementOn: 'interestIn',
                                              data: widget.userModel.interests,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then(
                                            (value) => setState(() {}));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/customer-satisfaction.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        spacing: 8.0, // Adjust the spacing between items as needed
                        runSpacing: 8.0, // Adjust the run spacing as needed
                        children: List.generate(
                          widget.userModel.interests!.length,
                              (i) => InkWell(
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
                              elevation: 4,
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
                                    widget.userModel.interests![i],
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 10,
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
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    if (widget.userModel.languages!.isNotEmpty) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color:
              FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'axwh3e0d' /* Languages I know */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ).centered(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        spacing: 8.0, // Adjust the spacing between items as needed
                        runSpacing: 8.0, // Adjust the run spacing as needed
                        children: chunkList(widget.userModel.languages!, 2).map((chunk) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: chunk.map((language) {
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
                                  elevation: 4,
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
                                        language,
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    if (widget.userModel.bio != null) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color:
              FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25, 0, 25, 0),
                      child: Text(
                        widget.userModel.bio! != null ? widget.userModel.bio! : "",
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            30, 10, 25, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'SHOW_PROFILE_COMP_Image_cxjaa12p_ON_TAP');
                            logFirebaseEvent('Image_alert_dialog');

                            if (widget.isIndividualProfile) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                            } else {
                              await showAlignedDialog(
                                context: context,
                                isGlobal: true,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(
                                    0, 0)
                                    .resolve(
                                    Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(
                                    0, 1)
                                    .resolve(
                                    Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: double.infinity,
                                      child:
                                      ComplementComponentWidget(
                                        userId: widget.userModel.id,
                                        complementOn: 'bio',
                                        userData: widget.userModel,
                                        data: widget.userModel.bio,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/customer-satisfaction.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    tempAboutList.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Container(
              width: 300,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35, 0, 0, 0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'gif1xfzr' /* Basics */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 25, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'SHOW_PROFILE_COMP_Image_mgsulbyc_ON_TAP');
                              logFirebaseEvent(
                                  'Image_alert_dialog');

                              if (widget.isIndividualProfile) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                              } else {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: true,
                                  avoidOverflow: false,
                                  targetAnchor: AlignmentDirectional(
                                      0, 0)
                                      .resolve(
                                      Directionality.of(context)),
                                  followerAnchor:
                                  AlignmentDirectional(0, 1)
                                      .resolve(Directionality.of(
                                      context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        width: double.infinity,
                                        child:
                                        ComplementComponentWidget(
                                          userId: widget.userModel.id,
                                          userData: widget.userModel,
                                          complementOn: 'basics',
                                          data: "",
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              }
                            },
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/customer-satisfaction_(1).png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          30, 0, 25, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (widget.userModel.work!.isNotEmpty)
                            Align(
                              alignment:
                              AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/suitcase_(1).png',
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(10, 2, 2, 2),
                                      child: Text(
                                        widget.userModel.work!.isNotEmpty ? widget.userModel.work![0].jobTitle : "",
                                        // userData['basicInfo']['work'].isNotEmpty ? userData['basicInfo']['work'][0]['jobTitle'] : "",
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .secondaryBackground,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (widget.userModel.education!.isNotEmpty)
                            Align(
                              alignment:
                              AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/mortarboard_(3).png',
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(10, 2, 2, 2),
                                      child: Text(
                                        widget.userModel.education![0].desc,
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .secondaryBackground,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (widget.userModel.gender != null && widget.userModel.gender!.isNotEmpty)
                            Align(
                              alignment:
                              AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/male-and-female-signs_(1).png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(10, 2, 2, 2),
                                      child: Text(
                                        widget.userModel!.gender!,
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .secondaryBackground,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (widget.userModel.location != null && widget.userModel.location != "")
                            Align(
                              alignment:
                              AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(0, 2, 2, 2),
                                      child: FaIcon(
                                        FontAwesomeIcons
                                            .locationArrow,
                                        color: FlutterFlowTheme.of(
                                            context)
                                            .secondaryBackground,
                                        size: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(10, 2, 2, 2),
                                      child: Text(
                                        widget.userModel!.location!,
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .secondaryBackground,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (widget.userModel.hometown != null && widget.userModel.hometown!.isNotEmpty)
                            Align(
                              alignment:
                              AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/home_(1).png',
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(10, 2, 2, 2),
                                      child: Text(
                                        widget.userModel!.hometown!,
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .secondaryBackground,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ].divide(SizedBox(height: 10)),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 5)),
              ),
            ),
          ),
        )
    );

    if (moreAboutUserItems.length > 0) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme
                  .of(context)
                  .secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme
                      .of(context)
                      .secondaryBackground,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(

                              35, 0, 0, 0),
                          child: Text(
                            widget.userModel.gender == "Men" ? "He" : "She" +
                                " love to tell",
                            style: FlutterFlowTheme
                                .of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme
                                  .of(context)
                                  .primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) =>
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 25, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'SHOW_PROFILE_COMP_Image_kq8flr6z_ON_TAP');
                                    logFirebaseEvent(
                                        'Image_alert_dialog');
                                    if (widget.isIndividualProfile) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                    } else {
                                      await showAlignedDialog(
                                        context: context,
                                        isGlobal: true,
                                        avoidOverflow: false,
                                        targetAnchor: AlignmentDirectional(
                                            0, 0)
                                            .resolve(
                                            Directionality.of(context)),
                                        followerAnchor:
                                        AlignmentDirectional(0, 1)
                                            .resolve(Directionality.of(
                                            context)),
                                        builder: (dialogContext) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              width: double.infinity,
                                              child:
                                              ComplementComponentWidget(
                                                userId: widget.userModel.id,
                                                complementOn: 'moreAboutUser',
                                                userData: widget.userModel,
                                                data: "",
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => setState(() {}));
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/customer-satisfaction.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            30, 0, 25, 0),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: moreAboutUserItems.length >= 5
                              ? 5
                              : moreAboutUserItems.length,
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: moreAboutUserItems[i],
                            );
                          },
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    if (moreAboutUserItems.length > 5) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme
                  .of(context)
                  .secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme
                      .of(context)
                      .primary,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              35, 0, 0, 0),
                          child: Text(
                            widget.userModel.gender == "Men" ? "He" : "She" +
                                " love to tell",
                            style: FlutterFlowTheme
                                .of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme
                                  .of(context)
                                  .secondaryBackground,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) =>
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 25, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'SHOW_PROFILE_COMP_Image_vmwvhkxy_ON_TAP');
                                    logFirebaseEvent(
                                        'Image_alert_dialog');
                                    if (widget.isIndividualProfile) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageWidget(userModel: widget.userModel,)));
                                    } else {
                                      await showAlignedDialog(
                                        context: context,
                                        isGlobal: true,
                                        avoidOverflow: false,
                                        targetAnchor: AlignmentDirectional(
                                            0, 0)
                                            .resolve(
                                            Directionality.of(context)),
                                        followerAnchor:
                                        AlignmentDirectional(0, 1)
                                            .resolve(Directionality.of(
                                            context)),
                                        builder: (dialogContext) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              width: double.infinity,
                                              child:
                                              ComplementComponentWidget(
                                                userId: widget.userModel.id,
                                                complementOn: 'moreAboutUser',
                                                userData: widget.userModel,
                                                data: "",
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => setState(() {}));
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/customer-satisfaction_(1).png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            30, 0, 25, 0),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (moreAboutUserItems.length - 5).clamp(0, 4),
                          // Ensure itemCount is within valid range
                          itemBuilder: (_, i) {
                            int indexToDisplay = i + 5;
                            Vx.log("The check is  " + indexToDisplay.toString() + " - " + moreAboutUserItems.length.toString());

                            if (indexToDisplay < moreAboutUserItems.length) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: moreAboutUserItems[indexToDisplay],
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    if (false) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/317/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/212/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/939/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/678/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/181/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/738/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/374/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/662/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/46/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/374/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/181/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                'https://picsum.photos/seed/678/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.00, -1.00),
                        child: Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Color(0xBD000000),
                                Color(0xE5000000)
                              ],
                              stops: [0, 1, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                            ),
                          ),
                          child: Align(
                            alignment:
                            AlignmentDirectional(0.00, -1.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 30, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color:
                                    FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional
                                        .fromSTEB(15, 0, 0, 5),
                                    child: Text(
                                      FFLocalizations.of(context)
                                          .getText(
                                        'lwa1klpf' /* Sonam's Instagram */,
                                      ),
                                      style:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ].addToStart(SizedBox(width: 40)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      );
    }

    if (false) {
      tempAboutList.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 60, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 0, 25, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '48fv844w' /* Sonam's Spotity */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color:
                                FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          'mvu0hn3m' /* Arjit Singh */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          '1j0qq3f2' /* Emiway */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]
                            .addToStart(SizedBox(width: 10))
                            .addToEnd(SizedBox(width: 10)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          'mvu0hn3m' /* Arjit Singh */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          '1j0qq3f2' /* Emiway */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]
                            .addToStart(SizedBox(width: 10))
                            .addToEnd(SizedBox(width: 10)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          'mvu0hn3m' /* Arjit Singh */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, -1.00),
                            child: Card(
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(1, 0, 0, 0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/552/600',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(5, 7, 10, 7),
                                      child: Text(
                                        FFLocalizations.of(context)
                                            .getText(
                                          '1j0qq3f2' /* Emiway */,
                                        ),
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]
                            .addToStart(SizedBox(width: 10))
                            .addToEnd(SizedBox(width: 10)),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ),
            ),
          )
      );
    }

    aboutTheUser = tempAboutList;
    Vx.log("The length is " + aboutTheUser.length.toString());

    setState(() {});

  }

  Widget moreAboutUserItem({required String path, required String text, required bool white}) {
    return Align(
      alignment:
      AlignmentDirectional(0.00, 1.00),
      child: Padding(
        padding:
        EdgeInsetsDirectional.fromSTEB(
            0, 5, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(0),
              child: Image.asset(
                path,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional
                  .fromSTEB(10, 2, 2, 2),
              child: Text(
                text,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily: 'Roboto',
                  color: white ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> moreAboutUserItems = [];

  buildAboutUserItems() {
    String? height = widget.userModel.height;
    List<Widget> moreAboutUserItems = [];
    heightString = height != null && height.contains("'")
        ? height + " feet"
        : height != null
        ? height + " cm"
        : "";

    if (widget.userModel.height != null)
      moreAboutUserItems.add(moreAboutUserItem(
          path: 'assets/images/ruler.png',
          text: heightString,
          white: false
      ));
    if (widget.userModel.doYouWorkout != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: 'assets/images/weights.png',
        text: widget.userModel.doYouWorkout!,
        white: false
      ));
    if (widget.userModel.educationLevel != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: 'assets/images/mortarboard_(2).png',
        text: widget.userModel.educationLevel!,
        white: false
      ));
    if (widget.userModel.doYouDrink != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: 'assets/images/drink.png',
        text: widget.userModel.doYouDrink!,
        white: false
      ));
    if (widget.userModel.smoke != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: 'assets/images/cigarette.png',
        text: widget.userModel.smoke!,
        white: false
      ));
    if (widget.userModel.havingKids != null)
      moreAboutUserItems.add(moreAboutUserItem(
          path: 'assets/images/feeding-bottle_(1).png',
          text: widget.userModel.havingKids!,
          white: true
      ));
    if (widget.userModel.starSign != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: 'assets/images/star_(1).png',
        text: widget.userModel.starSign!,
        white: true
      ));
    if (widget.userModel.politicalLearning != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: "assets/images/politics_(1).png",
        text: widget.userModel.politicalLearning!,
        white: true
      ));
    if (widget.userModel.religiousBelief != null)
      moreAboutUserItems.add(moreAboutUserItem(
        path: "assets/images/pray_(1).png",
        text: widget.userModel.religiousBelief!,
        white: true
      ));

    this.moreAboutUserItems = moreAboutUserItems;

    setState(() {});


  }

}
