import 'package:dazel_dating_app/pages/edit_profile/edit_profile_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pick_writte_prompt_page2_enter_prompt_model.dart';
export 'pick_writte_prompt_page2_enter_prompt_model.dart';

class PickWrittePromptPage2EnterPromptWidget extends StatefulWidget {
  late String prompt;
  String defaultAns = "";
  PickWrittePromptPage2EnterPromptWidget({Key? key, required this.prompt, required this.defaultAns}) : super(key: key);

  @override
  _PickWrittePromptPage2EnterPromptWidgetState createState() =>
      _PickWrittePromptPage2EnterPromptWidgetState();
}

class _PickWrittePromptPage2EnterPromptWidgetState
    extends State<PickWrittePromptPage2EnterPromptWidget> {
  late PickWrittePromptPage2EnterPromptModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => PickWrittePromptPage2EnterPromptModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PickWrittePromptPage2EnterPrompt'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.textController.text = widget.defaultAns;
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
              logFirebaseEvent('PICK_WRITTE_PROMPT_PAGE2_ENTER_PROMPT_Ic');
              logFirebaseEvent('Icon_navigate_back');
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
          ),
          actions: [
            IconButton(onPressed: () {
              Vx.log(widget.prompt + widget.defaultAns);
              int index = EditProfileWidget.writtenPromptModelList.indexWhere((element) => element.prompt == widget.prompt && element.answer == widget.defaultAns);
              if (index!=-1) EditProfileWidget.writtenPromptModelList.removeAt(index);
              setState(() {});
              Navigator.pop(context);
              VxToast.show(context, msg: "Deleted");
            }, icon: Icon(Icons.delete_outline, color: Colors.grey))
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Hero(
              tag: "",
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0x46677681),
                  ),
                ),
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.00, -1.00),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                            child: Text(
                              widget.prompt,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          fontSize: 20.0,
                                        ),
                                hintText: FFLocalizations.of(context).getText(
                                  '5dldjti0' /* Tell here... */,
                                ),
                                hintStyle:
                                    FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Inter',
                                          fontSize: 20.0,
                                        ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 20.0,
                                  ),
                              textAlign: TextAlign.start,
                              minLines: 1,
                              validator:
                                  _model.textControllerValidator.asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: AlignmentDirectional(0.00, 1.00),
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.defaultAns=="") {
                                if (_model.textController.text.isNotEmpty) {
                                  setState(() {
                                    EditProfileWidget.writtenPromptModelList
                                        .add(
                                        new WrittenPromptModel(widget.prompt,
                                            _model.textController.text));
                                  });

                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                } else {
                                  VxToast.show(
                                      context, msg: "Please enter answer");
                                }
                              } else {
                                if (_model.textController.text.isNotEmpty) {
                                  setState(() {
                                    int index = EditProfileWidget.writtenPromptModelList.indexWhere((element) => element.prompt == widget.prompt);
                                    EditProfileWidget.writtenPromptModelList[index].answer = _model.textController.text;
                                  });
                                  Navigator.pop(context);
                                  setState(() {});
                                } else {
                                  VxToast.show(
                                      context, msg: "Please enter answer");
                                }
                              }
                            },
                            child: Ink(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 0.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Text(
                                  "Save",
                                  style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
