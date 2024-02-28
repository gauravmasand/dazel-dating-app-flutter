import '/components/explore_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'explore_widget.dart' show ExploreWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExploreModel extends FlutterFlowModel<ExploreWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for ExploreComponent component.
  late ExploreComponentModel exploreComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    exploreComponentModel = createModel(context, () => ExploreComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    exploreComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
