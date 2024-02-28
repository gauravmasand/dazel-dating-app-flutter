import 'package:dazel_dating_app/index.dart';
import 'package:velocity_x/velocity_x.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_opening_question_model.dart';
export 'select_opening_question_model.dart';

class SelectOpeningQuestionWidget extends StatefulWidget {
  const SelectOpeningQuestionWidget({Key? key}) : super(key: key);

  @override
  _SelectOpeningQuestionWidgetState createState() =>
      _SelectOpeningQuestionWidgetState();
}

class _SelectOpeningQuestionWidgetState
    extends State<SelectOpeningQuestionWidget> {
  late SelectOpeningQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List isChecked = [];
  int checkedIndex = -1;

  void setAllToFalse() {
    setState(() {
      isChecked = List.generate(isChecked.length, (index) => false);
    });
  }

  List<String> openingQuestionsList = [
    'If you were a superhero, what would your superpower be?',
    'What’s your favorite ice cream flavor?',
    'If you could time-travel, which era would you visit?',
    'What’s the weirdest food combination you love?',
    'If your life was a movie, what genre would it be?',
    'What’s your go-to dance move?',
    'If you could be any animal for a day, what would you choose?',
    'What’s your ultimate comfort food?',
    'What’s your karaoke anthem?',
    'If you were stranded on an island, what three things would you bring?',
    'What’s your favorite meme/gif?',
    'What’s your secret talent?',
    'What’s the last thing you binge-watched?',
    'If you could live in a fictional world, where would you choose?',
    'What’s your favorite board game or video game?',
    'What’s the best joke you know by heart?',
    'What’s the most adventurous thing on your bucket list?',
    'What’s your dream vacation destination?',
    'What’s your opinion on pineapple on pizza?',
    'If you could meet any historical figure, who would it be?'
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectOpeningQuestionModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SelectOpeningQuestion'});

    for (int i = 0; i < openingQuestionsList.length; i++) {
      isChecked.add(false);
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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
            child: FlutterFlowIconButton(
              borderColor: Color(0xBF677681),
              borderRadius: 20.0,
              buttonSize: 40.0,
              fillColor: Color(0x00F83B46),
              icon: Icon(
                Icons.close,
                color: Color(0xBF677681),
                size: 18.0,
              ),
              onPressed: () async {
                logFirebaseEvent('SELECT_OPENING_QUESTION_close_ICN_ON_TAP');
                logFirebaseEvent('IconButton_navigate_back');
                context.safePop();
              },
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
              Container(
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/question-mark.png',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'ywvudaw2' /* Pick your opening question */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'mqx10cf8' /* Include a query in your profil... */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: openingQuestionsList.length,
                        itemBuilder: (_, i) {
                          return buildCustomContainer(context, openingQuestionsList[i], i);
                          },
                    ),
                  ].divide(SizedBox(height: 5.0)),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 1.00),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: InkWell(
                    onTap: () {
                      if (checkedIndex!=-1) EditProfileWidget.openingQuestion = openingQuestionsList[checkedIndex];
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    child: Ink(
                      child: Material(
                        color: Colors.transparent,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Container(
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
                              FFLocalizations.of(context).getText(
                                '0d121acy' /* Save and Close */,
                              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainer(BuildContext context, question, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 30.0, 0.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isChecked[index] ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(17.0),
          border: Border.all(
            color: Colors.black,
            width: 0.1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: BoxDecoration(
                      color: isChecked[index] ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(17.0, 0.0, 0.0, 0.0),
                      child: Text(
                        question,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: isChecked[index] ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryText,
                        ),
                      ).py(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: Checkbox(
                    value: isChecked[index],
                    onChanged: (value) {

                      setAllToFalse();

                      checkedIndex = index;

                      isChecked[index] = value!;

                      setState(() {});
                    },
                    activeColor: isChecked[index] ? FlutterFlowTheme.of(context).primary : Colors.white,
                    checkColor: isChecked[index] ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).py(5);
  }

}
