import '../../components/EnterItemWidget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_star_sign_model.dart';
export 'enter_star_sign_model.dart';

class EnterStarSignWidget extends StatefulWidget {
  const EnterStarSignWidget({Key? key}) : super(key: key);

  @override
  _EnterStarSignWidgetState createState() => _EnterStarSignWidgetState();
}

class _EnterStarSignWidgetState extends State<EnterStarSignWidget> {
  late EnterStarSignModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> starSignOptions = [
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn",
    "Aquarius",
    "Pisces",
    // Add more options here as needed
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterStarSignModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnterStarSign'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {
    logFirebaseEvent(
        'ENTER_STAR_SIGN_Text_xcbzuqse_ON_TAP');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterPolitics');
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
              logFirebaseEvent('ENTER_STAR_SIGN_Icon_802jdt5c_ON_TAP');
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/star.png',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '83umkq2a' /* What's your star sign? */,
                    ),
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
                              itemCount: starSignOptions.length,
                              itemBuilder: (context, index) {
                                final option = starSignOptions[index];
                                final bool isSelected = option == EditProfileWidget.moreAboutUser['starSign'];
                                return Item(
                                  context,
                                  option,
                                  first: index == 0,
                                  selected: isSelected,
                                  function: () {
                                    EditProfileWidget.moreAboutUser['starSign'] = option;
                                    navigateToNext();
                                  },
                                );
                              },
                            ),
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
                                      'o5p2nyfz' /* Skip */,
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
                                  FlutterFlowTheme.of(context).secondaryBackground,
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
