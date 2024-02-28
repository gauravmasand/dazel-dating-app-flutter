import '/components/user_profile_component_widget.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'main_swipe_component_widget.dart' show MainSwipeComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class MainSwipeComponentModel
    extends FlutterFlowModel<MainSwipeComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SwipeableStack widget.
  late SwipeableCardSectionController swipeableStackController;
  // Model for UserProfileComponent component.
  late UserProfileComponentModel userProfileComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    swipeableStackController = SwipeableCardSectionController();
    userProfileComponentModel =
        createModel(context, () => UserProfileComponentModel());
  }

  void dispose() {
    userProfileComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
