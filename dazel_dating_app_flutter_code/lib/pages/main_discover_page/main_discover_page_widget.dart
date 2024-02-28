import '../../backend/LocalDatabase.dart';
import '../../backend/models/user_data_model.dart';
import '/components/show_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_discover_page_model.dart';
export 'main_discover_page_model.dart';

class MainDiscoverPageWidget extends StatefulWidget {
  late UserData? model;
  bool? isIndividualProfile = true;
  MainDiscoverPageWidget({Key? key, this.model, required this.isIndividualProfile}) : super(key: key);

  @override
  _MainDiscoverPageWidgetState createState() => _MainDiscoverPageWidgetState();
}

class _MainDiscoverPageWidgetState extends State<MainDiscoverPageWidget> {
  late MainDiscoverPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainDiscoverPageModel());


    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MainDiscoverPage'});

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
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.showProfileModel,
            updateCallback: () => setState(() {}),
            child: ShowProfileWidget(
              userModel: widget.model!,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: FlutterFlowTheme.of(context).secondary,
              ),
              color: FlutterFlowTheme.of(context).secondary,
              isIndividualProfile: widget.isIndividualProfile!,
            ),
          ),
        ),
      ),
    );
  }
}
