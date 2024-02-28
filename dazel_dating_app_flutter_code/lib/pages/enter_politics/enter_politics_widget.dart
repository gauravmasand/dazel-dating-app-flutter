import '../../components/EnterItemWidget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_politics_model.dart';
export 'enter_politics_model.dart';

class EnterPoliticsWidget extends StatefulWidget {
  const EnterPoliticsWidget({Key? key}) : super(key: key);

  @override
  _EnterPoliticsWidgetState createState() => _EnterPoliticsWidgetState();
}

class _EnterPoliticsWidgetState extends State<EnterPoliticsWidget> {
  late EnterPoliticsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> politicalLearningOptions = [
    "Neutral",
    "Independent",
    "Progressive",
    "Conservative",
    "Communist",
    "Socialist",
    // Add more options here as needed
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterPoliticsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnterPolitics'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {

    logFirebaseEvent(
        'ENTER_POLITICS_PAGE_Text_pzaq4g74_ON_TAP');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterReligion');
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
              logFirebaseEvent('ENTER_POLITICS_PAGE_Icon_zjm7lhkw_ON_TAP');
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
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
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
                          'assets/images/conference.png',
                          width: 80.0,
                          height: 80.0,
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
                      '2zl01oci' /* What is your political learnin... */
                      ,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: politicalLearningOptions.length,
                  itemBuilder: (context, index) {
                    final option = politicalLearningOptions[index];
                    final bool isSelected = option == EditProfileWidget.moreAboutUser['politicalLearning'];

                    return Item(
                      context,
                      option,
                      first: index == 0,
                      selected: isSelected,
                      function: () {
                        EditProfileWidget.moreAboutUser['politicalLearning'] = option;
                        navigateToNext();
                      },
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 50.0),
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
                          'i9buicfa' /* Skip */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
          ),
        ),
      ),
    );
  }
}
