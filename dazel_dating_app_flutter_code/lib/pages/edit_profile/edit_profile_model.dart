import '/components/delete_media_widget.dart';
import '/components/relation_goals_component_widget.dart';
import '/components/select_profile_media_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  Local state fields for this page.

  List<bool> isMediaAvailable = [];
  void addToIsMediaAvailable(bool item) => isMediaAvailable.add(item);
  void removeFromIsMediaAvailable(bool item) => isMediaAvailable.remove(item);
  void removeAtIndexFromIsMediaAvailable(int index) =>
      isMediaAvailable.removeAt(index);
  void insertAtIndexInIsMediaAvailable(int index, bool item) =>
      isMediaAvailable.insert(index, item);
  void updateIsMediaAvailableAtIndex(int index, Function(bool) updateFn) =>
      isMediaAvailable[index] = updateFn(isMediaAvailable[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
