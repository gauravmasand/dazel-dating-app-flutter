import '/components/explore_component_widget.dart';
import '/components/find_your_conversation_widget.dart';
import '/components/matches_got_components_widget.dart';
import '/components/profile_component_widget.dart';
import '/components/show_profile_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'main_home_widget.dart' show MainHomeWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class MainHomeModel extends FlutterFlowModel<MainHomeWidget> {
  ///  Local state fields for this page.


  bool isNotificationVisible = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  static TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for ProfileComponent component.
  late ProfileComponentModel profileComponentModel;
  // State field(s) for SwipeableStackMain widget.
  late SwipeableCardSectionController swipeableStackMainController;
  // Model for ShowProfile component.
  late ShowProfileModel showProfileModel;
  // Model for MatchesGotComponents component.
  late MatchesGotComponentsModel matchesGotComponentsModel1;
  // State field(s) for TextField widget.

  // Model for FindYourConversation component.

  // Model for ExploreComponent component.
  late ExploreComponentModel exploreComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    profileComponentModel = createModel(context, () => ProfileComponentModel());
    swipeableStackMainController = SwipeableCardSectionController();
    showProfileModel = createModel(context, () => ShowProfileModel());
    matchesGotComponentsModel1 =
        createModel(context, () => MatchesGotComponentsModel());

    exploreComponentModel = createModel(context, () => ExploreComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    profileComponentModel.dispose();
    showProfileModel.dispose();
    matchesGotComponentsModel1.dispose();
    tabBarController?.dispose();
    exploreComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
