import 'package:dazel_dating_app/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_your_height_model.dart';
export 'enter_your_height_model.dart';

class EnterYourHeightWidget extends StatefulWidget {
  const EnterYourHeightWidget({Key? key}) : super(key: key);

  @override
  _EnterYourHeightWidgetState createState() => _EnterYourHeightWidgetState();
}

class _EnterYourHeightWidgetState extends State<EnterYourHeightWidget> {
  late EnterYourHeightModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  bool _isCm = true; // Initially, show height in centimeters

  bool areFieldsEmpty = true;
  String buttonText = "Skip";

  // Mask for centimeters
  final cmMask = MaskTextInputFormatter(
    mask: "###", // Customize the mask pattern as needed
    filter: {"#": RegExp(r'[0-9]')}, // Allowing only numbers
  );

// Mask for feet and inches
  final feetMask = MaskTextInputFormatter(
    mask: '#', // Only single digit for feet
    filter: {"#": RegExp(r'[0-9]')},
  );

  final inchesMask = MaskTextInputFormatter(
    mask: '##', // Two digits for inches
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterYourHeightModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnterYourHeight'});

    if (EditProfileWidget.moreAboutUser['height'] != null) {
      if (EditProfileWidget.moreAboutUser['height'].contains("'")) {
        List temp = EditProfileWidget.moreAboutUser['height'].split("'");
        _feetController.text = temp[0];
        _inchesController.text = temp[1];
      } else {
        _cmController.text = EditProfileWidget.moreAboutUser['height'];
      }
    }

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
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('ENTER_YOUR_HEIGHT_Icon_6fyoovqj_ON_TAP');
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
                      'assets/images/measuring-tape.png',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'scr6iqsd' /* What is your height? */,
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 70.0, 30.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isCm
                          ? Expanded(
                        child: TextFormField(
                          onChanged: (value) =>
                              setState(() {
                                areFieldsEmpty =
                                _isCm ? _cmController.text.isEmpty : _feetController.text.isEmpty || _inchesController.text.isEmpty;
                                buttonText = areFieldsEmpty ? 'Skip' : 'Next';
                              }),
                          controller: _cmController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            cmMask,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Height in centimeters',
                            labelStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                      )
                          : Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                onChanged: (value) =>
                                  setState(() {
                                    areFieldsEmpty =
                                    _isCm ? _cmController.text.isEmpty : _feetController.text.isEmpty || _inchesController.text.isEmpty;
                                    buttonText = areFieldsEmpty ? 'Skip' : 'Next';
                                  }),
                                controller: _feetController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  feetMask,
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Feet',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Inter',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 0.1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: TextFormField(
                                onChanged: (value) =>
                                    setState(() {
                                      areFieldsEmpty =
                                      _isCm ? _cmController.text.isEmpty : _feetController.text.isEmpty || _inchesController.text.isEmpty;
                                      buttonText = areFieldsEmpty ? 'Skip' : 'Next';
                                    }),
                                controller: _inchesController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  inchesMask,
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Inches',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Inter',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 0.1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.swap_horiz),
                        onPressed: () {
                          setState(() {
                            _isCm = !_isCm; // Toggle between cm and feet/inches
                            _cmController.clear(); // Clear the input fields when toggling
                            _feetController.clear();
                            _inchesController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (buttonText=="Next") {
                          String selectedValue = "";
                          if (_cmController.text.isNotEmpty) {
                            selectedValue = _cmController.text;
                          } else if (_feetController.text.isNotEmpty
                              && _inchesController.text.isNotEmpty) {
                            selectedValue =
                            "${_feetController.text}'${_inchesController.text}";
                          }

                          EditProfileWidget.moreAboutUser['height'] =
                              selectedValue;

                          context.pushNamed('EnterExercise');
                        } else {
                          context.safePop();
                          popCountEditProfileMoreDetails--;
                          context.pushNamed('EnterExercise');
                        }
                      },
                      child: Text(
                        buttonText,
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
