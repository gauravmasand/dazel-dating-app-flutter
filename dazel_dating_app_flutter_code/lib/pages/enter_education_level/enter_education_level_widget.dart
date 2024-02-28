import 'package:dazel_dating_app/index.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/EnterItemWidget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_education_level_model.dart';
export 'enter_education_level_model.dart';

class EnterEducationLevelWidget extends StatefulWidget {
  const EnterEducationLevelWidget({Key? key}) : super(key: key);

  @override
  _EnterEducationLevelWidgetState createState() =>
      _EnterEducationLevelWidgetState();
}

class _EnterEducationLevelWidgetState extends State<EnterEducationLevelWidget> {
  late EnterEducationLevelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> educationLevels = [
    "Sixth form",
    "Technical college",
    "Undergraduate",
    "Undergraduate degree",
    "Postgraduate",
    "Postgraduate degree"
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterEducationLevelModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnterEducationLevel'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {
    logFirebaseEvent('ENTER_EDUCATION_LEVEL_Text_99xfdso2_ON_T');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterDrink');
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('ENTER_EDUCATION_LEVEL_Icon_ccrf1yqd_ON_T');
              logFirebaseEvent('Icon_navigate_back');
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/mortarboard.png',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'fndw4p92' /* What's your education? */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            ListView.builder(
                              primary: false,
                            shrinkWrap: true,
                            itemCount: educationLevels.length,
                              itemBuilder: (context, index) {
                                final educationLevel = educationLevels[index];
                                return Item(
                                  context,
                                  educationLevel,
                                  first: index == 0,
                                  function: () {
                                    EditProfileWidget.moreAboutUser['educationLevel'] = educationLevel;
                                    navigateToNext();
                                  },
                                  selected: EditProfileWidget.moreAboutUser['educationLevel'] == educationLevel
                                    ? true : false
                                );
                              },
                            ),
                      // Item(context, "Sixth form", first: true, function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "Sixth form";
                      //         navigateToNext();
                      //       }),
                      //       Item(context, "Technical collage", function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "Technical collage";
                      //         navigateToNext();
                      //       }),
                      //       Item(context, "I'm an undergrad", function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "I'm an undergrad";
                      //         navigateToNext();
                      //       }),
                      //       Item(context, "Undergraduate degree", function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "Undergraduate degree";
                      //         navigateToNext();
                      //       }),
                      //       Item(context, "I'm a postgraduate", function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "I'm a postgraduate";
                      //         navigateToNext();
                      //       }),
                      //       Item(context, "Postgraduate degree", function: () {
                      //         EditProfileWidget.moreAboutUser['educationLevel'] = "Postgraduate degree";
                      //         navigateToNext();
                      //       }),
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 60.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    navigateToNext(skip: true);
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'f1uc1aj1' /* Skip */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  Color(0x00FFFFFF)
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                            ),
                            alignment: AlignmentDirectional(0.00, 0.00),
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
      ),
    );
  }

}
