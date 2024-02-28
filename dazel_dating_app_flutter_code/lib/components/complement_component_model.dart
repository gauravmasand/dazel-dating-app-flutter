import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'complement_component_widget.dart' show ComplementComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ComplementComponentModel
    extends FlutterFlowModel<ComplementComponentWidget> {
  ///  Local state fields for this component.

  String nameAge = '';

  String onWhat = '';

  ///  State fields for stateful widgets in this component.

  // State field(s) for complementTextField widget.
  FocusNode? complementTextFieldFocusNode;
  TextEditingController? complementTextFieldController;
  String? Function(BuildContext, String?)?
      complementTextFieldControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    complementTextFieldFocusNode?.dispose();
    complementTextFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
