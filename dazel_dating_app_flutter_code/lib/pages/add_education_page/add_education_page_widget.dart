import 'package:velocity_x/velocity_x.dart';

import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_education_page_model.dart';
export 'add_education_page_model.dart';

class AddEducationPageWidget extends StatefulWidget {
  AddEducationPageWidget({
    Key? key,
    bool? edit,
    required this.model
  })  : this.edit = edit ?? false,
        super(key: key);

  final bool edit;
  final EducationModel model;

  @override
  _AddEducationPageWidgetState createState() => _AddEducationPageWidgetState();
}

class _AddEducationPageWidgetState extends State<AddEducationPageWidget> {
  late AddEducationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddEducationPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddEducationPage'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();


    _model.textController.text = widget.model.title;
    _model.datePicked = DateTime.now();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
          ),
          title: Text(
            widget.edit ? 'Edit Institute' : 'Add Education',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Sora',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: IconButton(
                onPressed: () {
                  if (widget.edit) {
                    setState(() {
                      EditProfileWidget.basics['education'].remove(widget.model);
                      EditProfileWidget.basics['education'].add(new EducationModel(_model.textController.text, _model.datePicked!.year.toString() +"-"+ _model.datePicked!.month.toString() +"-"+ _model.datePicked!.day.toString()));
                    });
                    Navigator.pop(context);
                  } else {
                    if (_model.textController.text.isEmpty) {
                      VxToast.show(context, msg: "Please enter all fields correctly");
                    } else {
                      setState(() {
                        EditProfileWidget.basics['education'].add(new EducationModel(
                            _model.textController.text,
                            _model.datePicked!.year.toString()));
                        Navigator.pop(context);
                      });
                    }
                  }

                },
                icon: Icon(
                  Icons.done,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
            ),
          ],
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        width: 0.2,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              'gfrvr0yl' /* Institute */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('ADD_EDUCATION_Container_03jixw6w_ON_TAP');
                    logFirebaseEvent('Container_date_time_picker');
                    await showModalBottomSheet<bool>(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              minimumDate: DateTime(1900),
                              initialDateTime: getCurrentTimestamp,
                              maximumDate: DateTime(2050),
                              use24hFormat: false,
                              onDateTimeChanged: (newDateTime) =>
                                  safeSetState(() {
                                _model.datePicked = newDateTime;
                              }),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        width: 0.2,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(-1.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          _model.datePicked!.year.toString() +"-"+ _model.datePicked!.month.toString() +"-"+ _model.datePicked!.day.toString(),
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 15.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.edit)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        border: Border.all(
                          width: 0.2,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'li7mgkjf' /* Remove Job */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context).error,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
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
