import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pick_your_gender_pronouns_page_model.dart';
export 'pick_your_gender_pronouns_page_model.dart';

class PickYourGenderPronounsPageWidget extends StatefulWidget {
  const PickYourGenderPronounsPageWidget({Key? key}) : super(key: key);

  @override
  _PickYourGenderPronounsPageWidgetState createState() =>
      _PickYourGenderPronounsPageWidgetState();
}

class _PickYourGenderPronounsPageWidgetState
    extends State<PickYourGenderPronounsPageWidget> {
  late PickYourGenderPronounsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PickYourGenderPronounsPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PickYourGenderPronounsPage'});
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Icon(
            Icons.chevron_left,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'sa1rwsd7' /* Update your gender */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Sora',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: true,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/icons8-message-100.png',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '7dmjd9hk' /* What are your pronouns? */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Sora',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 15.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '5ncvcwu6' /* Express your authentic self on... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Sora',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Divider(
                  thickness: 5.0,
                  color: Color(0x13677681),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, -1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'ix2v9r44' /* Pick up 3 pronouns */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Sora',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, -1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'kswzs34r' /* You have the flexibility to re... */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .override(
                            fontFamily: 'Sora',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    width: double.infinity,
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_zweh');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'qx6q3bdv' /* she/her */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 3.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_p9ps');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'nkij48ct' /* he/him */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_vgl0');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'oa03bz7j' /* they/them */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_8vr3');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '6a4i5kea' /* ze/zir */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 3.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_5k9r');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'vd8txnvn' /* xe/xim */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_hcgf');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'bwbev97i' /* co/co */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_tmef');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'rx4jz1ta' /* ey/em */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 3.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_c7cr');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '5l6w8sbx' /* ve/ver */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'PICK_YOUR_GENDER_PRONOUNS_Container_2qmr');
                                    logFirebaseEvent(
                                        'Container_update_page_state');
                                    setState(() {
                                      _model.isChecked = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isChecked
                                          ? Color(0xFFFFE1E1)
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(13.0),
                                      border: Border.all(
                                        color: _model.isChecked
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Color(0x00000000),
                                        width: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'ppiqaaha' /* per/per */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(17.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 10.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'v4tmetbh' /* Display on your profile as: */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 5.0, 0.0, 12.0),
                            child: Text(
                              _model.pickedPronounce!,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (responsiveVisibility(
                  context: context,
                  tablet: false,
                ))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: FFLocalizations.of(context).getText(
                              'kvc3fms4' /* Pronouns not listed? */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: FFLocalizations.of(context).getText(
                              'kw9zxcfc' /*  - Contect Support */,
                            ),
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                Align(
                  alignment: AlignmentDirectional(0.00, 1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 20.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'PICK_YOUR_GENDER_PRONOUNS_Container_um77');
                        logFirebaseEvent('Container_navigate_back');
                        context.safePop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).secondary,
                            width: 0.0,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'vvhxdfgu' /* Save */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }
}
