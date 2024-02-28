import '/components/user_profile_component_widget.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'main_swipe_component_model.dart';
export 'main_swipe_component_model.dart';

class MainSwipeComponentWidget extends StatefulWidget {
  const MainSwipeComponentWidget({
    Key? key,
    required this.hieghtMainSwipeComp,
  }) : super(key: key);

  final int? hieghtMainSwipeComp;

  @override
  _MainSwipeComponentWidgetState createState() =>
      _MainSwipeComponentWidgetState();
}

class _MainSwipeComponentWidgetState extends State<MainSwipeComponentWidget> {
  late MainSwipeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainSwipeComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.hieghtMainSwipeComp?.toDouble(),
      decoration: BoxDecoration(),
      child: FlutterFlowSwipeableStack(
        topCardHeightFraction: 1.0,
        middleCardHeightFraction: 1.0,
        bottomCardHeightFraction: 1.0,
        topCardWidthFraction: 0.92,
        middleCardWidthFraction: 0.92,
        bottomCardWidthFraction: 0.92,
        onSwipeFn: (index) {},
        onLeftSwipe: (index) {},
        onRightSwipe: (index) {},
        onUpSwipe: (index) {},
        onDownSwipe: (index) {},
        itemBuilder: (context, index) {
          return [
            () => Stack(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: wrapWithModel(
                              model: _model.userProfileComponentModel,
                              updateCallback: () => setState(() {}),
                              child: UserProfileComponentWidget(
                                heightUserProfileComp:
                                    widget.hieghtMainSwipeComp!,
                              ),
                            ),
                          ),
                          ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Container(
                                width: 100.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            30.0, 0.0, 30.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'MAIN_SWIPE_COMPONENT_Container_iniqnry0_');
                                            logFirebaseEvent(
                                                'Container_swipeable_stack');
                                            _model.swipeableStackController
                                                .triggerSwipeLeft();
                                          },
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF7F87),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'MAIN_SWIPE_COMPONENT_Icon_knktaw3d_ON_TA');
                                                  logFirebaseEvent(
                                                      'Icon_swipeable_stack');
                                                  _model
                                                      .swipeableStackController
                                                      .triggerSwipeLeft();
                                                },
                                                child: Icon(
                                                  Icons.chevron_left_outlined,
                                                  color: Colors.white,
                                                  size: 45.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 1.00),
                                      child: Builder(
                                        builder: (context) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 20.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'MAIN_SWIPE_COMPONENT_Text_8ikqsnax_ON_TA');
                                              logFirebaseEvent('Text_share');
                                              await Share.share(
                                                '👋 Hey [Friend\'s Name]!  Guess what? I just stumbled upon a profile on Dazel that screams \"cool vibes\" – it\'s [User\'s Name]!  They\'re all about [mention a couple of interests or hobbies], and I thought, \"Hey, I know someone equally awesome who might dig this vibe!\" 🚀  Check it out on Dazel: [Profile Link]',
                                                sharePositionOrigin:
                                                    getWidgetBoundingBox(
                                                        context),
                                              );
                                            },
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '2hd698vy' /* Hide and Report */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, -1.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 25.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'MAIN_SWIPE_COMPONENT_Container_uyot8984_');
                                            logFirebaseEvent(
                                                'Container_swipeable_stack');
                                            _model.swipeableStackController
                                                .triggerSwipeUp();
                                          },
                                          child: Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/custom_(4).png',
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/star_(3).png',
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment(0.00, 0.00),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            30.0, 0.0, 30.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'MAIN_SWIPE_COMPONENT_Container_nmmefd2s_');
                                            logFirebaseEvent(
                                                'Container_swipeable_stack');
                                            _model.swipeableStackController
                                                .triggerSwipeRight();
                                          },
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF7F87),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 15.0, 10.0, 10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/heart_(1).png',
                                                  width: 45.0,
                                                  height: 45.0,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment(0.00, 0.00),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 20.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'MAIN_SWIPE_COMPONENT_Container_qh9n4cdn_');
                                      logFirebaseEvent('Container_share');
                                      await Share.share(
                                        '💌 Check out this profile! Hey [Friend\'s Name]! 👋  I came across this awesome profile on [Your App Name], and I thought you might be interested! 🌟  [User\'s Name] is into [mention a couple of interests or hobbies], and they seem like a [positive adjective] person. Check out their profile and see if you think we\'ve found a match! 😉  [Profile Link]  Cheers to making new connections! 🚀',
                                        sharePositionOrigin:
                                            getWidgetBoundingBox(context),
                                      );
                                    },
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x0C677681),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '9z5pz75s' /* Recommend to a Friend */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.00, 1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 25.0, 120.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'MAIN_SWIPE_COMPONENT_Container_qug14c7s_');
                            logFirebaseEvent('Container_swipeable_stack');
                            _model.swipeableStackController.triggerSwipeUp();
                          },
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'MAIN_SWIPE_COMPONENT_Image_ib68ztiy_ON_T');
                                    logFirebaseEvent('Image_swipeable_stack');
                                    _model.swipeableStackController
                                        .triggerSwipeRight();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/custom_(4).png',
                                      width: 60.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/star_(3).png',
                                    width: 45.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0.00, 0.00),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ][index]();
        },
        itemCount: 1,
        controller: _model.swipeableStackController,
        enableSwipeUp: false,
        enableSwipeDown: false,
      ),
    );
  }
}
