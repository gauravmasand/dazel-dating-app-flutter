import 'package:dazel_dating_app/backend/SwipeUser.dart';
import 'package:dazel_dating_app/pages/got_match/got_match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../backend/FetchRequest.dart';
import '../../backend/models/user_data_model.dart';
import '../../components/show_profile_widget.dart';
import '../../flutter_flow/flutter_flow_model.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../got_match/got_match_widget.dart';
import 'main_home_widget.dart';

class MainSwipePage extends StatefulWidget {
  const MainSwipePage({super.key});

  @override
  State<MainSwipePage> createState() => _MainSwipePageState();
}

class _MainSwipePageState extends State<MainSwipePage> {

  late ShowProfileModel showProfileModel;
  List<UserData> mainUsers = [];
  List<Widget> userCards = [];
  bool noMoreUsers = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProfileModel = createModel(context, () => ShowProfileModel());

    Future<Map<String, dynamic>> users = Fetch.fetchUsersProfiles();

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
      Map<String, dynamic> result = await Fetch.fetchUsersProfiles();

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
    // TODO: implement dispose
    super.dispose();
    showProfileModel.dispose();
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
      'The card $currentIndex was undo from the ${direction.name}',
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (noMoreUsers) {
      Vx.log('noMoreUsers');
      return Container(
        child: Center(
          child: Text("No more users"),
        ),
      );
    } else if (mainUsers.isEmpty) {
      Vx.log('mainUsers.isEmpty');
      return Center(
        child: CircularProgressIndicator(),
      );
    }  else if (mainUsers.length >= 2) {
      Vx.log('mainUsers.isNotEmpty');
      return CardSwiper(
        duration: Duration(milliseconds: 250),
        controller: MainHomeWidget.controller,
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
      );
    } else {
      Vx.log('mainUsers.length < 2');
      return NoMoreUsers();
    }
  }

  Widget NoMoreUsers() {
    return Container(
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
    ).p(10);
  }

}
