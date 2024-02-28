import 'package:dazel_dating_app/index.dart';
import 'package:dazel_dating_app/pages/add_education_page/add_education_page_model.dart';
import 'package:dazel_dating_app/pages/edit_profile/edit_profile_widget.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'show_select_education_page_model.dart';
export 'show_select_education_page_model.dart';

class ShowSelectEducationPageWidget extends StatefulWidget {
  const ShowSelectEducationPageWidget({Key? key}) : super(key: key);

  @override
  _ShowSelectEducationPageWidgetState createState() =>
      _ShowSelectEducationPageWidgetState();
}

class _ShowSelectEducationPageWidgetState
    extends State<ShowSelectEducationPageWidget> {
  late ShowSelectEducationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> drinkOptions = [
    "Frequently",
    "Socially",
    "Rarely",
    "Never",
    "Sober",
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowSelectEducationPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ShowSelectEducationPage'});
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
            FFLocalizations.of(context).getText(
              'dtkbdd48' /* Education */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Sora',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.00, -1.00),
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'v8hq98eg' /* You can show one institute on ... */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddEducationPageWidget(model: new EducationModel("", ""), edit: false,)));

                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border.all(
                            width: 0.1,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-1.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jzl79drn' /* Add Education */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (EditProfileWidget.basics['education'].isNotEmpty) Align(
                    alignment: AlignmentDirectional(-1.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '4x0v8eka' /* Institutes you've added */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  ReorderableListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: EditProfileWidget.basics['education'].length,
                    onReorder: (int oldIndex, int newIndex) async {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final EducationModel item = EditProfileWidget.basics['education'].removeAt(oldIndex);
                        EditProfileWidget.basics['education'].insert(newIndex, item);
                      });
                    },
                    itemBuilder: (_, i) {
                      return KeyedSubtree(
                        key: ValueKey('item_$i'),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('AddEducationPage');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                FlutterFlowTheme.of(context).secondaryBackground,
                                border: Border.all(
                                  width: 0.1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Theme(
                                        //   data: ThemeData(
                                        //     checkboxTheme: CheckboxThemeData(
                                        //       visualDensity: VisualDensity.compact,
                                        //       materialTapTargetSize:f
                                        //       MaterialTapTargetSize.shrinkWrap,
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //         BorderRadius.circular(4.0),
                                        //       ),
                                        //     ),
                                        //     unselectedWidgetColor:
                                        //     FlutterFlowTheme.of(context)
                                        //         .secondaryText,
                                        //   ),
                                        //   child: Checkbox(
                                        //     value: _model.checkboxValue ??= true,
                                        //     onChanged: (newValue) async {
                                        //       setState(() =>
                                        //       _model.checkboxValue = newValue!);
                                        //     },
                                        //     activeColor:
                                        //     FlutterFlowTheme.of(context).primary,
                                        //     checkColor:
                                        //     FlutterFlowTheme.of(context).info,
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 20.0, 0.0),
                                                child: Text(
                                                  EditProfileWidget.basics['education'][i].title,
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Inter',
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 20.0, 10.0),
                                                child: Text(
                                                  EditProfileWidget.basics['education'][i].desc,
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Inter',
                                                    color: Colors.black,
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 5.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.edit_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 16.0,
                                      ),
                                      onPressed: () async {

                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddEducationPageWidget(model: EditProfileWidget.basics['education'][i], edit: true,)));

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
