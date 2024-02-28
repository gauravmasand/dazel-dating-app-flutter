import '../pick_writte_prompt_page2_enter_prompt/pick_writte_prompt_page2_enter_prompt_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pick_writtenprompt_page_model.dart';
export 'pick_writtenprompt_page_model.dart';

class PickWrittenpromptPageWidget extends StatefulWidget {
  const PickWrittenpromptPageWidget({Key? key}) : super(key: key);

  @override
  _PickWrittenpromptPageWidgetState createState() =>
      _PickWrittenpromptPageWidgetState();
}

class _PickWrittenpromptPageWidgetState
    extends State<PickWrittenpromptPageWidget> {
  late PickWrittenpromptPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> writtenPromptsList = [
    "My ideal Saturday night is...",
    "A perfect day for me involves...",
    "The last concert I attended was...",
    "One thing on my bucket list is...",
    "If I won the lottery, I would...",
    "I'm passionate about...",
    "A talent I wish I had is...",
    "My favorite way to relax is...",
    "The best trip I've taken was...",
    "A movie that made me cry was...",
    "I feel happiest when...",
    "Something I'm proud of...",
    "If I could meet anyone, it would be...",
    "The last book I read was...",
    "My favorite podcast is...",
    "One goal I'm working towards is...",
    "Something I can't live without is...",
    "The most spontaneous thing I've done is...",
    "I'm known for...",
    "The most adventurous thing I've done is...",
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PickWrittenpromptPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PickWrittenpromptPage'});
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('PICK_WRITTENPROMPT_Icon_v2a9dvbb_ON_TAP');
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
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/images/icons8-dating-app-96_(1).png',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '7xi11fjq' /* Pick a Profile Prompt */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '64yqqybw' /* This is an ideal moment to rev... */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    primary: false,
                      shrinkWrap: true,
                      itemCount: writtenPromptsList.length,
                      itemBuilder: (_, i) {
                    return Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'PICK_WRITTENPROMPT_Container_ubbux6b5_ON');
                          logFirebaseEvent('Container_navigate_to');

                          Navigator.push(context, MaterialPageRoute(builder: (context) => PickWrittePromptPage2EnterPromptWidget(
                            prompt: writtenPromptsList[i],
                            defaultAns: "",
                          )));

                        },
                        child: Hero(
                          tag: writtenPromptsList[i],
                          child: Container(
                            width: double.infinity,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Color(0x55677681),
                                width: 1.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Text(
                                writtenPromptsList[i],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
