import 'package:dazel_dating_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../backend/FetchRequest.dart';
import '../../backend/SwipeUser.dart';
import '../../backend/models/user_data_model.dart';
import '../../components/show_profile_model.dart';
import '../../components/show_profile_widget.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../got_match/got_match_widget.dart';



class ExploreProfilePage extends StatefulWidget {
  static CardSwiperController controller = CardSwiperController();
  ExploreProfilePage({
    Key? key,
    List? lookingFor,
    String? text,
  }) : super(key: key) {
    this.lookingFor = lookingFor ?? [];
    this.text = text ?? '';
  }

  late String text;
  late List lookingFor;

  @override
  _ExploreProfilePageState createState() => _ExploreProfilePageState();
}

class _ExploreProfilePageState extends State<ExploreProfilePage> {

  late ShowProfileModel showProfileModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<UserData> mainUsers = [];
  List<Widget> userCards = [];
  bool noMoreUsers = false;

  @override
  void initState() {
    super.initState();

    showProfileModel = createModel(context, () => ShowProfileModel());

    Future<Map<String, dynamic>> users = Fetch.fetchSpecificTypeOfDate(widget.lookingFor);
    users.then((result) {
      if (result['success']) {
        final List<UserData> userList = result['users'];

        setState(() {
          mainUsers = userList;

          for (var item in mainUsers) {
            userCards.add(
              ShowProfileWidget(
                userModel: item,
                icon: Icon(
                  Icons.undo,
                  color: FlutterFlowTheme.of(context).secondary,
                ),
                color: FlutterFlowTheme.of(context).primaryBackground,
                isIndividualProfile: false,
              ),
            );
          }

          if (mainUsers.isEmpty) setState(() => noMoreUsers = true);

          Vx.log(mainUsers);
        });


      } else {
        // Handle the error
        Vx.log('Error: ${result['error']}');
      }
    });
  }

  // Function to fetch more users and append them to the mainUsers list
  Future<void> fetchMoreUsers() async {
    try {
      Vx.log('Fetching more users...');
      Map<String, dynamic> result = await Fetch.fetchSpecificTypeOfDate(widget.lookingFor);

      if (result['success']) {
        final List<UserData> userList = result['users'];

        Vx.log('Fetched ${userList.length} more users: $userList');

        setState(() {
          mainUsers.addAll(userList);

          for (var item in mainUsers) {
            userCards.add(
              ShowProfileWidget(
                userModel: item,
                icon: Icon(
                  Icons.undo,
                  color: FlutterFlowTheme.of(context).secondary,
                ),
                color: FlutterFlowTheme.of(context).primaryBackground,
                isIndividualProfile: false,
              ),
            );
          }

          Vx.log(mainUsers);
        });

        if (mainUsers.isEmpty) setState(() => noMoreUsers = true);

      } else if (!result['success']) {
        setState(() => noMoreUsers = true);
      } else {
        Vx.log('Error fetching more users: ${result['error']}');
      }
    } catch (error) {
      // Handle network or other errors
      Vx.log('Error fetching more users: $error');
    }
  }

  @override
  void dispose() {

    super.dispose();
  }


  _swipeRight(previousIndex) async {
    String result = await swipeRight(otherUserId: mainUsers[previousIndex].id) as String;
    if (result == "Right swipe successful. It's a match!") {
      updateAcceptStatus(mainUsers[previousIndex].id, true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => GotMatchWidget(
        media: mainUsers[previousIndex].media!,
        id: mainUsers[previousIndex].id,
        name: mainUsers[previousIndex].name!,
      )));
    }
  }


  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {

    Vx.log(direction.name + ' ' + mainUsers[previousIndex].id);

    if (direction.name == 'right') {
      _swipeRight(previousIndex);
      Vx.log('Swiped right on ${mainUsers[previousIndex].email!}');
    } else {
      updateAcceptStatus(mainUsers[previousIndex].id, false);
      swipeLeft(mainUsers[previousIndex].id);
      Vx.log('Swiped left on ${mainUsers[previousIndex].email!}');
    }

    Vx.log('The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top and total is ${mainUsers.length}');

    // Check if currentIndex is not null and there are only 3 or fewer users remaining
    if (currentIndex != null && mainUsers.length - currentIndex <= 3) {
      // Fetch more users when there are 3 or fewer remaining
      fetchMoreUsers();
    }

    if (currentIndex == null) {
      setState(() => noMoreUsers = true);
    }

    return true;

  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }


  @override
  Widget build(BuildContext context) {
    // if (isiOS) {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarBrightness: Theme.of(context).brightness,
    //       systemStatusBarContrastEnforced: true,
    //     ),
    //   );
    // }

    // List<Container> cards = [
    //   Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     decoration: BoxDecoration(
    //       color: FlutterFlowTheme.of(context).primaryBackground,
    //     ),
    //     child: wrapWithModel(
    //       model: _model.showProfileModel,
    //       updateCallback: () => setState(() {}),
    //       child: ShowProfileWidget(
    //         userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, doYouDrink: "", doYouWorkout: "", educationLevel: "", havingKids: "", height: "", politicalLearning: "", religiousBelief: "", smoke: "", starSign: "", spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, hometown: "", location: "", signupDateAndTime: "signupDateAndTime", version: 1),
    //         icon: Icon(
    //           Icons.undo,
    //           color: FlutterFlowTheme.of(context).secondary,
    //         ),
    //         color: FlutterFlowTheme.of(context).primaryBackground,
    //         isIndividualProfile: false,
    //       ),
    //     ),
    //   ),
    //   Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     decoration: BoxDecoration(
    //       color: FlutterFlowTheme.of(context).primaryBackground,
    //     ),
    //     child: wrapWithModel(
    //       // userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
    //       model: _model.showProfileModel,
    //       updateCallback: () => setState(() {}),
    //       child: ShowProfileWidget(
    //         userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], doYouDrink: "", doYouWorkout: "", educationLevel: "", havingKids: "", height: "", politicalLearning: "", religiousBelief: "", smoke: "", starSign: "", typeOfDate: "typeOfDate", interests: [], isSpotlight: false, hometown: "", location: "", autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
    //         icon: Icon(
    //           Icons.undo,
    //           color: FlutterFlowTheme.of(context).secondary,
    //         ),
    //         color: FlutterFlowTheme.of(context).primaryBackground,
    //         isIndividualProfile: false,
    //       ),
    //     ),
    //   ),
    //   Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     decoration: BoxDecoration(
    //       color: FlutterFlowTheme.of(context).primaryBackground,
    //     ),
    //     child: wrapWithModel(
    //       // userModel: UserData(id: "id", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
    //       model: _model.showProfileModel,
    //       updateCallback: () => setState(() {}),
    //       child: ShowProfileWidget(
    //         userModel: UserData(id: "id", doYouDrink: "", doYouWorkout: "", educationLevel: "", havingKids: "", height: "", politicalLearning: "", religiousBelief: "", smoke: "", starSign: "", email: "email", phone: "phone", name: "name", dob: "dob", gender: "gender", media: ['media'], typeOfDate: "typeOfDate", interests: [], isSpotlight: false, autoSpotlight: false, spotlightStartMilliseconds: "spotlightStartMilliseconds", hometown: "", location: "", bio: "bio", languages: [], work: [], education: [], writtenPrompts: [], openingQuestions: [], incognitoMode: false, signupDateAndTime: "signupDateAndTime", version: 1),
    //         icon: Icon(
    //           Icons.undo,
    //           color: FlutterFlowTheme.of(context).secondary,
    //         ),
    //         color: FlutterFlowTheme.of(context).primaryBackground,
    //         isIndividualProfile: false,
    //       ),
    //     ),
    //   ),
    // ];

    // return GestureDetector(
    //   onTap: () => _model.unfocusNode.canRequestFocus
    //       ? FocusScope.of(context).requestFocus(_model.unfocusNode)
    //       : FocusScope.of(context).unfocus(),
    //   child: Scaffold(
    //     key: scaffoldKey,
    //     backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    //     body: SafeArea(
    //       top: true,
    //       child: CardSwiper(
    //         duration: Duration(milliseconds: 250),
    //         controller: MainHomeWidget.controller,
    //         allowedSwipeDirection: AllowedSwipeDirection.all(),
    //         onSwipe: _onSwipe,
    //         onUndo: _onUndo,
    //         padding: EdgeInsets.all(0),
    //         cardsCount: cards.length,
    //         isLoop: false,
    //         cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
    //           return cards[index];
    //         },
    //       ),
    //     ),
    //   ),
    // );

    if (noMoreUsers) {
      Vx.log('noMoreUsers');
      return Scaffold(
        body: Container(
          child: Center(
            child: Text("No more users"),
          ),
        ),
      );
    } else if (mainUsers.isEmpty) {
      Vx.log('mainUsers.isEmpty');
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }  else if (mainUsers.length >= 2) {
      Vx.log('mainUsers.isNotEmpty');
      return Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            buttonSize: 46.0,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {

              context.pop();
            },
          ),
          title: Text(
            widget.text,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Inter',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CardSwiper(
          duration: Duration(milliseconds: 250),
          controller: ExploreProfilePage.controller,
          allowedSwipeDirection: AllowedSwipeDirection.all(),
          onSwipe: _onSwipe,
          onUndo: _onUndo,
          padding: EdgeInsets.all(0),
          cardsCount: mainUsers.length,
          isLoop: false,
          cardBuilder: (context, i, percentThresholdX, percentThresholdY) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: wrapWithModel(
                model: showProfileModel,
                updateCallback: () => setState(() {}),
                child: userCards[i],
              ),
            );
          },
        ),
      );
    } else {
      Vx.log('mainUsers.length < 2');
      return NoMoreUsers();
    }
  }

  Widget NoMoreUsers() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            "No more users",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ).p(10),
    );
  }

}
