import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import 'package:dazel_dating_app/components/EnterItemWidget.dart';

import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_kids_model.dart';
export 'enter_kids_model.dart';

class EnterKidsWidget extends StatefulWidget {
  const EnterKidsWidget({Key? key}) : super(key: key);

  @override
  _EnterKidsWidgetState createState() => _EnterKidsWidgetState();
}

class _EnterKidsWidgetState extends State<EnterKidsWidget> {
  late EnterKidsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> kidsOptions = [
    "Want someday",
    "Don't want",
    "Have and want more",
    "Have and don't want more",
    "Not sure yet",
    "Have kids",
    "Open to kids",
    "I hate kids",
    // Add more options here as needed
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterKidsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'EnterKids'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {
    logFirebaseEvent(
        'ENTER_KIDS_PAGE_Text_upsqn9bk_ON_TAP');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterStarSign');
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
              logFirebaseEvent('ENTER_KIDS_PAGE_Icon_veee0x18_ON_TAP');
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
                          'assets/images/maternity.png',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 20.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'hhel7yaa' /* What's your dream approach to ... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
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
                              itemCount: kidsOptions.length,
                              itemBuilder: (context, index) {
                                final option = kidsOptions[index];
                                final bool isSelected = option == EditProfileWidget.moreAboutUser['havingKids'];

                                return Item(
                                  context,
                                  option,
                                  first: index == 0,
                                  selected: isSelected,
                                  function: () {
                                    EditProfileWidget.moreAboutUser['havingKids'] = option;
                                    navigateToNext();
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 100.0),
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
                                      'fvw6c9m8' /* Skip */,
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
