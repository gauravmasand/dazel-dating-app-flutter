import 'package:dazel_dating_app/backend/models/signup_model.dart';
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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'auth_enter_b_o_d_model.dart';
export 'auth_enter_b_o_d_model.dart';

class AuthEnterBODWidget extends StatefulWidget {
  const AuthEnterBODWidget({Key? key}) : super(key: key);

  @override
  _AuthEnterBODWidgetState createState() => _AuthEnterBODWidgetState();
}

class _AuthEnterBODWidgetState extends State<AuthEnterBODWidget>
    with TickerProviderStateMixin {
  late AuthEnterBODModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller3 = TextEditingController(text: DateTime.now().toString());
  String _valueChanged3 = '';
  String _valueToValidate3 = '';
  String _valueSaved3 = '';


  final _formKey = GlobalKey<FormState>();



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
    _model = createModel(context, () => AuthEnterBODModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Auth_Enter_BOD'});
    _model.dobController ??= TextEditingController();
    _model.dobFocusNode ??= FocusNode();
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
                                          'pj9o9cx7' /* Dazel */,
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
                                                'AUTH_ENTER_B_O_D_arrow_back_rounded_ICN_');
                                            logFirebaseEvent(
                                                'IconButton_navigate_back');
                                            context.safePop();
                                          },
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'swa02mzp' /* Unveil the Birthdate Magic! */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .override(
                                              fontFamily: 'Sora',
                                              fontSize: 30.0,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 24.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'hlro3nrb' /* Unlock a world of possibilitie... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                      // Generated code for this DOB Widget...
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                              child: Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model.dobController,
                                                  focusNode: _model.dobFocusNode,
                                                  autofocus: true,
                                                  autofillHints: [AutofillHints.birthday],
                                                  textInputAction: TextInputAction.next,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                                    hintText: FFLocalizations.of(context).getText(
                                                      'yfotpxfm' /* E.g., 26/12/2004 */,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme.of(context).primary,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme.of(context).error,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme.of(context).error,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                                  keyboardType: TextInputType.datetime,
                                                  cursorColor: FlutterFlowTheme.of(context).primary,
                                                  validator: (String? str) {
                                                    if (str == null || str.isEmpty) {
                                                      return "Please enter a date of birth";
                                                    }

                                                    final dobPattern = r'^(\d{1,2})\/(\d{1,2})\/(\d{4})$';
                                                    if (!RegExp(dobPattern).hasMatch(str)) {
                                                      return "Please enter a valid date of birth (dd/mm/yyyy)";
                                                    }

                                                    final dateParts = str.split('/');
                                                    final day = int.tryParse(dateParts[0]);
                                                    final month = int.tryParse(dateParts[1]);
                                                    final year = int.tryParse(dateParts[2]);

                                                    if (day == null || month == null || year == null) {
                                                      return "Please enter a valid date of birth (dd/mm/yyyy)";
                                                    }

                                                    if (day < 1 || day > 31) {
                                                      return "Day should be between 1 and 31";
                                                    }

                                                    if (month < 1 || month > 12) {
                                                      return "Month should be between 1 and 12";
                                                    }

                                                    final dob = DateTime(year, month, day);
                                                    final currentDate = DateTime.now();
                                                    var age = currentDate.year - dob.year;

                                                    if (currentDate.month < dob.month ||
                                                        (currentDate.month == dob.month && currentDate.day < dob.day)) {
                                                      age--;
                                                    }

                                                    if (age < 18) {
                                                      return "You must be at least 18 years old";
                                                    }

                                                    return null; // Return null for valid input
                                                  },

                                                  inputFormatters: [_model.dobMask],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                              AlignmentDirectional(1.00, -1.00),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {


                                                    if (_formKey.currentState!.validate()) {
                                                      SignupModel.dob = _model.dobController.text;
                                                      Vx.log(SignupModel.dob);

                                                      logFirebaseEvent(
                                                          'AUTH_ENTER_B_O_D_CONTINUE_BTN_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Button_navigate_to');

                                                      context.pushNamed(
                                                          'Auth_enter_gender');
                                                    }


                                                  },
                                                  text: FFLocalizations.of(context)
                                                      .getText(
                                                    'c68ytws2' /* Continue */,
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
