import 'package:dazel_dating_app/index.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../profile_create/auth_intrested_in/auth_intrested_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'intrest_selection_model.dart';
export 'intrest_selection_model.dart';

class IntrestSelectionWidget extends StatefulWidget {
  const IntrestSelectionWidget({Key? key}) : super(key: key);

  @override
  _IntrestSelectionWidgetState createState() => _IntrestSelectionWidgetState();
}

class _IntrestSelectionWidgetState extends State<IntrestSelectionWidget> {
  late IntrestSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IntrestSelectionModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'IntrestSelection'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {

    });
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
              'owpk1v4f' /* Intrests */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Lato',
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
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: ListView(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.00, -1.00),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'wz3fd1tl' /* You've selected all five inter... */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: interestCategories.length,
                                itemBuilder: (_, i) {
                                  return createInterest(interestCategories[i].title, interestCategories[i].interests);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
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
                        setState(() {});
                        Navigator.pop(context);
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
    );
  }


  Widget createInterest(title, List<String> list) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment:
          AlignmentDirectional(
              -1.00, -1.00),
          child: Padding(
            padding:
            EdgeInsetsDirectional
                .fromSTEB(
                0.0,
                0.0,
                0.0,
                10.0),
            child: Text(
              title,
              style:
              FlutterFlowTheme.of(
                  context)
                  .labelLarge
                  .override(
                fontFamily:
                'Inter',
                color: FlutterFlowTheme.of(
                    context)
                    .primaryText,
                fontSize:
                18.0,
                fontWeight:
                FontWeight
                    .bold,
              ),
            ),
          ),
        ),
        Padding(
          padding:
          EdgeInsetsDirectional
              .fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: Wrap(
              direction: Axis.horizontal,
              clipBehavior: Clip.antiAlias,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              runSpacing: 5,
              children: List.generate(
                list.length,
                    (index) => InterestItemSelection(option: list[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class InterestItemSelection extends StatefulWidget {
  final String option;
  InterestItemSelection({Key? key, required this.option}) : super(key: key);

  @override
  State<InterestItemSelection> createState() => _InterestItemSelectionState();
}

class _InterestItemSelectionState extends State<InterestItemSelection> {
  late bool flag;

  @override
  void initState() {
    super.initState();
    flag = EditProfileWidget.interestList.contains(widget.option);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (EditProfileWidget.interestList.contains(widget.option)) {
              flag = !flag;
              EditProfileWidget.interestList.remove(widget.option);
            } else if (EditProfileWidget.interestList.length < 5) {
              if (!EditProfileWidget.interestList.contains(widget.option)) {
                flag = !flag;
                EditProfileWidget.interestList.add(widget.option);
              }
            } else {
              VxToast.show(context, msg: "You can select only 5");
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            color: !flag
                ? FlutterFlowTheme.of(context).secondaryBackground
                : FlutterFlowTheme.of(context).primary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
            child: Text(
              widget.option,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: !flag
                    ? FlutterFlowTheme.of(context).primaryText
                    : FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

