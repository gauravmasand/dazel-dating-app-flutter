import '../../components/EnterItemWidget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_drink_model.dart';
export 'enter_drink_model.dart';

class EnterDrinkWidget extends StatefulWidget {
  const EnterDrinkWidget({Key? key}) : super(key: key);

  @override
  _EnterDrinkWidgetState createState() => _EnterDrinkWidgetState();
}

class _EnterDrinkWidgetState extends State<EnterDrinkWidget> {
  late EnterDrinkModel _model;

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
    _model = createModel(context, () => EnterDrinkModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'EnterDrink'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ENTER_DRINK_EnterDrink_ON_INIT_STATE');
      logFirebaseEvent('EnterDrink_navigate_back');
      // context.safePop();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  navigateToNext({skip = false}) {
    logFirebaseEvent(
        'ENTER_DRINK_PAGE_Text_kk5ihi18_ON_TAP');
    logFirebaseEvent('Text_navigate_to');
    if (skip) {
      popCountEditProfileMoreDetails--;
      context.safePop();
    }
    context.pushNamed('EnterSmoke');
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
              logFirebaseEvent('ENTER_DRINK_PAGE_Icon_6s8pol9y_ON_TAP');
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
                      'assets/images/beer.png',
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
                      'j0nl47fo' /* Do you drink? */,
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: drinkOptions.length,
                  itemBuilder: (context, index) {
                    final option = drinkOptions[index];
                    final bool isSelected =
                        option == EditProfileWidget.moreAboutUser['doYouDrink'];

                    return Item(
                      context,
                      option,
                      first: index == 0,
                      selected: isSelected,
                      function: () {
                        EditProfileWidget.moreAboutUser['doYouDrink'] = option;
                        navigateToNext();
                      },
                    );
                  },
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
                        navigateToNext(skip: true);
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'q4rnbq7x' /* Skip */,
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
