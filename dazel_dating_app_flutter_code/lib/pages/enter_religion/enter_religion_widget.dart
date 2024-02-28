import '../../components/EnterItemWidget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_religion_model.dart';
export 'enter_religion_model.dart';

class EnterReligionWidget extends StatefulWidget {
  const EnterReligionWidget({Key? key}) : super(key: key);

  @override
  _EnterReligionWidgetState createState() => _EnterReligionWidgetState();
}

class _EnterReligionWidgetState extends State<EnterReligionWidget> {
  late EnterReligionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> religiousBeliefs = [
    "Agnostic",
    "Atheist",
    "Buddhist",
    "Catholic",
    "Christian",
    "Hindu",
    "Jain",
    "Jewish",
    "Mormon",
    "Latter-day Saint",
    "Muslim",
    "Zoroastric",
    "Sikh",
    "Spiritual",
    "Other",
    // Add more options as needed
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterReligionModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnterReligion'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {
    logFirebaseEvent(
        'ENTER_RELIGION_PAGE_Text_chcstyum_ON_TAP');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterYourHeight');
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
              logFirebaseEvent('ENTER_RELIGION_PAGE_Icon_b5d8izmm_ON_TAP');
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
                          'assets/images/pray.png',
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
                      'qrhocafs' /* Are you affiliated with any re... */,
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
                              shrinkWrap: true,
                              primary: false,
                              itemCount: religiousBeliefs.length,
                              itemBuilder: (context, index) {
                                final belief = religiousBeliefs[index];
                                return Item(
                                  context,
                                  belief,
                                  first: index == 0,
                                  function: () {
                                    EditProfileWidget.moreAboutUser['religiousBelief'] = belief;
                                    for (int i = popCountEditProfileMoreDetails; i > 0; i--) {
                                      context.safePop();
                                    }
                                    popCountEditProfileMoreDetails = 10;
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 0.0, 60.0),
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
                                      'xum01w3l' /* Skip */,
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
