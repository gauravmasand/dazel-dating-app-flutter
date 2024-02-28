import '/components/show_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'main_discover_page_widget.dart' show MainDiscoverPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainDiscoverPageModel extends FlutterFlowModel<MainDiscoverPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for ShowProfile component.
  late ShowProfileModel showProfileModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    showProfileModel = createModel(context, () => ShowProfileModel());
  }

  void dispose() {
    unfocusNode.dispose();
    showProfileModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
