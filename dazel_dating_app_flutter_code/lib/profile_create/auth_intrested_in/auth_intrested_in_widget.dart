import 'package:dazel_dating_app/auth/MainAuth.dart';
import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/backend/models/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

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
import 'auth_intrested_in_model.dart';
export 'auth_intrested_in_model.dart';

class AuthIntrestedInWidget extends StatefulWidget {
  const AuthIntrestedInWidget({Key? key}) : super(key: key);

  @override
  _AuthIntrestedInWidgetState createState() => _AuthIntrestedInWidgetState();
}

class _AuthIntrestedInWidgetState extends State<AuthIntrestedInWidget>
    with TickerProviderStateMixin {
  late AuthIntrestedInModel _model;

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
    _model = createModel(context, () => AuthIntrestedInModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Auth_Intrested_in'});
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
                                          '5ruepgiw' /* Dazel */,
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
                                                'AUTH_INTRESTED_IN_arrow_back_rounded_ICN');
                                            logFirebaseEvent(
                                                'IconButton_navigate_back');
                                            SignupModel.interestedIn = [];
                                            context.safePop();
                                          },
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'm09wv5zb' /* Let's Get Personal! */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 24.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '9uqfo3ac' /* What do we call you? Your awes... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: interestCategories.length,
                                            itemBuilder: (_, i) {
                                              return createInterest(interestCategories[i].title, interestCategories[i].interests);
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.00, -1.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 45.0, 0.0, 16.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {

                                              if (SignupModel.interestedIn.isNotEmpty) {
                                                var data = await MainAuth.signup(context);
                                                int response = data['statusCode'];
                                                Vx.log(response);
                                                if (response==200) {

                                                  SharesPrefs.setUserData(data['data']);

                                                  context.pushNamed('MainHome');

                                                } else {
                                                  VxToast.show(context, msg: data['error']);
                                                }

                                              }

                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'sc3es449' /* Start Connecting */,
                                            ),
                                            options: FFButtonOptions(
                                              width: 200.0,
                                              height: 44.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: Colors.white,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
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
                    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createInterest(title, List<String> list) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment:
          AlignmentDirectional(
              -1.00, -1.00),
          child: Padding(
            padding:
            EdgeInsetsDirectional
                .fromSTEB(
                0.0,
                0.0,
                0.0,
                10.0),
            child: Text(
              title,
              style:
              FlutterFlowTheme.of(
                  context)
                  .labelLarge
                  .override(
                fontFamily:
                'Inter',
                color: FlutterFlowTheme.of(
                    context)
                    .primaryText,
                fontSize:
                18.0,
                fontWeight:
                FontWeight
                    .bold,
              ),
            ),
          ),
        ),
        Padding(
          padding:
          EdgeInsetsDirectional
              .fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: Wrap(
              direction: Axis.horizontal,
              clipBehavior: Clip.antiAlias,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              runSpacing: 5,
              children: List.generate(
                list.length,
                    (index) => InterestItem(option: list[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class InterestItem extends StatefulWidget {
  late String option;
  InterestItem({Key? key, required this.option}) : super(key: key);

  @override
  State<InterestItem> createState() => _InterestItemState();
}

class _InterestItemState extends State<InterestItem> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (SignupModel.interestedIn.contains(widget.option)) {
              flag = !flag;
              SignupModel.interestedIn.remove(widget.option);
            } else if (SignupModel.interestedIn.length < 5) {
              if (!SignupModel.interestedIn.contains(widget.option)) {
                flag = !flag;
                SignupModel.interestedIn.add(widget.option);
              }
            } else {
              VxToast.show(context, msg: "You can select only 5");
            }

          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            color: flag
                ? FlutterFlowTheme.of(context).secondaryBackground
                : FlutterFlowTheme.of(context).primary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
            child: Text(
              widget.option,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: flag
                    ? FlutterFlowTheme.of(context).primaryText
                    : FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InterestCategory {
  final String title;
  final List<String> interests;

  InterestCategory({required this.title, required this.interests});
}

List<InterestCategory> interestCategories = [
  InterestCategory(
    title: 'Creative Minds',
    interests: [
      '🎨 Art & Painting',
      '📸 Photography',
      '🎭 Theater & Drama',
      '📚 Bookworm & Bibliophile',
      '🎵 Music & Concerts',
      '🖌️ DIY & Crafting',
      '🎬 Movies & Film Buff',
      '🧩 Puzzle Solving',
    ],
  ),
  InterestCategory(
    title: 'Fitness & Wellness',
    interests: [
      '🏋️‍♂️ Fitness & Gym',
      '🧘‍ Yoga & Meditation',
      '🥗 Healthy Eating',
      '🏊‍Swimming & Sports',
      '🚴‍Cycling & Trails',
      '🏃‍Running & Marathons',
    ],
  ),
  InterestCategory(
    title: 'Adventure Seekers',
    interests: [
      '✈️ Travel & Exploring',
      '🏖️ Beach & Sunsets',
      '🏔️ Hiking & Mountains',
      '🚣‍ Watersports',
      '🌴 Island Hopping',
      '🌇 Urban Explorations',
    ],
  ),
  InterestCategory(
    title: 'Food Enthusiasts',
    interests: [
      '🍣 Sushi & Seafood',
      '🍔 Burgers & Fast Food',
      '🌮 Tacos & Mexican',
      '🍝 Pasta & Italian',
      '🍱 Asian Cuisine',
    ],
  ),
  InterestCategory(
    title: 'Animal Lovers',
    interests: [
      '🐶 Dogs & Pets',
      '🐱 Cats & Kittens',
      '🐦 Birds & Bird Watching',
    ],
  ),
  InterestCategory(
    title: 'Pop Culture Fans',
    interests: [
      '🎮 Gaming & eSports',
      '🎬 Movies & TV Shows',
      '🎤 Music & Concerts',
    ],
  ),
  InterestCategory(
    title: 'Tech & Innovation',
    interests: [
      '🤖 Tech & Gadgets',
      '📱 App Development',
      '🚀 Space & Astronomy',
      '🧬 Science & Innovations',
    ],
  ),
  InterestCategory(
    title: 'Social Causes',
    interests: [
      '🌍 Environmental Causes',
      '🕊️ Peace & Humanity',
      '🌈 LGBTQ+ Support',
      '🌱 Plant-based Lifestyle',
    ],
  ),
];

