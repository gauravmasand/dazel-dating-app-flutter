import 'dart:io';

import 'package:dazel_dating_app/auth/MainAuth.dart';
import 'package:dazel_dating_app/backend/LocalDatabase.dart';
import 'package:dazel_dating_app/index.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:image_picker_plus/image_picker_plus.dart' as ipp;
import 'package:http/http.dart' as http;

import '../../backend/FetchRequest.dart';
import '../../backend/Function.dart';
import '../../backend/Instagram/InstagramLoginScreen.dart';
import '/components/delete_media_widget.dart';
import '/components/relation_goals_component_widget.dart';
import '/components/select_profile_media_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';

int popCountEditProfileMoreDetails = 9;

class EducationModel {
  late String title, desc;
  EducationModel(this.title, this.desc);

  Map<String, dynamic> toMap() {
    return {
      'educationTitle': title,
      'institute': desc,
    };
  }

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      json['educationTitle'],
      json['institute'],
    );
  }

  // Add this toJson method
  Map<String, dynamic> toJson() {
    return {
      'educationTitle': title,
      'institute': desc,
    };
  }

}

class WorkModel {
  late String jobTitle, organization;
  WorkModel(this.jobTitle, this.organization);

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'organization': organization,
    };
  }

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      json['jobTitle'],
      json['organization'],
    );
  }

  // Add this toJson method
  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'organization': organization,
    };
  }

}

class WrittenPromptModel {
  late String prompt, answer;
  WrittenPromptModel(this.prompt, this.answer);

  Map<String, dynamic> toMap() {
    return {
      'prompt': prompt,
      'answer': answer,
    };
  }

  factory WrittenPromptModel.fromJson(Map<String, dynamic> json) {
    return WrittenPromptModel(

      json['prompt'],
      json['answer']
    );
  }

  // Add this toJson method
  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'answer': answer,
    };
  }

}

void navigateToNextPageForMoreAboutUser(BuildContext context) {
  final Map<String, String?> fieldRoutes = {
    'EnterExercise': EditProfileWidget.moreAboutUser['doYouWorkout'],
    'EnterEducationLevel': EditProfileWidget.moreAboutUser['educationLevel'],
    'EnterDrink': EditProfileWidget.moreAboutUser['doYouDrink'],
    'EnterSmoke': EditProfileWidget.moreAboutUser['smoke'],
    'EnterKids': EditProfileWidget.moreAboutUser['havingKids'],
    'EnterStarSign': EditProfileWidget.moreAboutUser['starSign'],
    'EnterPolitics': EditProfileWidget.moreAboutUser['politicalLearning'],
    'EnterReligion': EditProfileWidget.moreAboutUser['religiousBelief'],
  };

  for (var routeName in fieldRoutes.keys) {
    final fieldValue = fieldRoutes[routeName];
    if (fieldValue == null || fieldValue.isEmpty) {
      context.pushNamed(routeName);
    }
  }
}

class EditProfileWidget extends StatefulWidget {
  static String dateType = "";
  static List interestList = [];
  static List languagesList = [];
  static List mediaList = [];
  static Map<String, dynamic> basics = {};
  static Map<String, dynamic> moreAboutUser = {};
  static List<WrittenPromptModel> writtenPromptModelList = [];
  static String openingQuestion = "";
  static List instaPosts = [];
  EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getDetails() async {
    EditProfileWidget.dateType = await SharesPrefs.getValue("typeOfDate");
    EditProfileWidget.interestList = await SharesPrefs.getValue("interests")==null ? [] : await SharesPrefs.getValue("interests");
    EditProfileWidget.languagesList = await SharesPrefs.getValue("languages")==null ? [] : await SharesPrefs.getValue("languages");
    EditProfileWidget.basics = await SharesPrefs.getValue("basicInfo");
    if (EditProfileWidget.basics['education'] != null) {
      List<EducationModel> list = [];
      for (Map<String, dynamic> item in EditProfileWidget.basics['education']) {
        list.add(new EducationModel(item['educationTitle'], item['institute']));
      }
      EditProfileWidget.basics['education'] = list;
    } else {
      EditProfileWidget.basics['education'] = [];
    }
    if (EditProfileWidget.basics['work'] != null) {
      List<WorkModel> list = [];
      for (Map<String, dynamic> item in EditProfileWidget.basics['work']) {
        list.add(new WorkModel(item['jobTitle'], item['organization']));
      }
      EditProfileWidget.basics['work'] = list;
    } else {
      EditProfileWidget.basics['work'] = [];
    }
    EditProfileWidget.moreAboutUser = await SharesPrefs.getValue("moreAboutUser");
    _model.textController.text = await SharesPrefs.getValue("bio")==null ? "" : await SharesPrefs.getValue("bio");
    EditProfileWidget.mediaList = await SharesPrefs.getValue("media");

    print("details are " + await SharesPrefs.getValue("_id"));
    Vx.log(EditProfileWidget.basics);
    Vx.log(await SharesPrefs.getUserData());

    fetchImages();

    setState(() {});
  }

  late List<Uint8List> globalMedia = [];
  List<Asset> images = [];

  pickImage() async {

    images = await MultiImagePicker.pickImages(
      selectedAssets: images,
      androidOptions: AndroidOptions(
        maxImages: 6,
        actionBarColor: FlutterFlowTheme.of(context).primary,
        statusBarColor: FlutterFlowTheme.of(context).primary,
      ),
      iosOptions: IOSOptions(
        settings: CupertinoSettings(),
      ),
    );

    globalMedia = await Future.wait(images.map((asset) async {
      ByteData byteData = await asset.getByteData();
      return byteData.buffer.asUint8List();
    }));

    setState(() {});
  }


  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
    File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  Future fetchImages() async {
    // List imageUrls = [];
    //
    // for (var item in EditProfileWidget.mediaList) {
    //   imageUrls.add(buildImageUrl(item));
    // }
    //
    // for (String imageUrl in imageUrls) {
    //   var response = await http.get(Uri.parse(imageUrl));
    //
    //   if (response.statusCode == 200) {
    //     ByteData byteData = ByteData.view(response.bodyBytes.buffer);
    //     Asset asset = Asset(
    //       imageUrl,
    //       'Image',
    //       100,
    //       100,
    //     );
    //
    //     images.add(asset);
    //   } else {
    //     print('Failed to load image from $imageUrl. Status code: ${response.statusCode}');
    //   }
    // }

  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'EditProfile'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    getDetails();





    // EditProfileWidget.instaPosts = Fetch.fetchInstagramPosts(context) as List;
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Color(0x00F83B46),
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: Color(0x00F83B46),
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              logFirebaseEvent('EDIT_PROFILE_chevron_left_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'fcjfh13i' /* Dazel Date */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Color(0x00F83B46),
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 25.0,
                fillColor: Color(0x00F83B46),
                icon: Icon(
                  Icons.check,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                onPressed: () async {

                  Vx.log(globalMedia.length);

                  if (globalMedia.length > 0) {
                    List<File> listOfImages = [];
                    for (var item in images) {
                      listOfImages.add(await getImageFileFromAssets(item));
                    }
                    Map res = await MainAuth.uploadMedia(context, listOfImages);
                    if (res['status']) {
                      EditProfileWidget.mediaList = res['media'];
                      await SharesPrefs.setValue('media', EditProfileWidget.mediaList);
                    } else {
                      return;
                    }
                  }

                  // for (var item in EditProfileWidget.basics['education']) {
                  //   Vx.log(item.title);
                  //   Vx.log(item.desc);
                  // }

                  var moreAboutUser = {
                    'height': EditProfileWidget.moreAboutUser['height'],
                    'doYouWorkout': EditProfileWidget.moreAboutUser['doYouWorkout'],
                    'educationLevel': EditProfileWidget.moreAboutUser['educationLevel'],
                    'doYouDrink': EditProfileWidget.moreAboutUser['doYouDrink'],
                    'smoke': EditProfileWidget.moreAboutUser['smoke'],
                    'havingKids': EditProfileWidget.moreAboutUser['havingKids'],
                    'starSign': EditProfileWidget.moreAboutUser['starSign'],
                    'politicalLearning': EditProfileWidget.moreAboutUser['politicalLearning'],
                    'religiousBelief': EditProfileWidget.moreAboutUser['religiousBelief']
                  };

                  Vx.log(moreAboutUser);

                  Map<String, dynamic> data = {
                    'typeOfDate': EditProfileWidget.dateType,
                    'interests': EditProfileWidget.interestList,
                    'languages': EditProfileWidget.languagesList,
                    'media': EditProfileWidget.mediaList,
                    'bio': _model.textController.text,
                    'basicInfo': {
                      'work': EditProfileWidget.basics['work'].map((model) => model.toMap()).toList(),
                      'education': EditProfileWidget.basics['education'].map((model) => model.toMap()).toList(),
                      'gender': EditProfileWidget.basics['gender'],
                      'location': EditProfileWidget.basics['location'],
                      'hometown': EditProfileWidget.basics['hometown']
                    },
                    'moreAboutUser': moreAboutUser,
                    'writtenPrompts': EditProfileWidget.writtenPromptModelList.map((model) => model.toMap()).toList(),
                    'openingQuestions': [EditProfileWidget.openingQuestion],
                  };

                  var userData = await MainAuth.updateUserProfile(context, data);
                  if (data != null) {
                    SharesPrefs.setUserData(userData);
                    Navigator.pop(context);
                    VxToast.show(context, msg: "Done");
                  }


                },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.00, -1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'xcd1ae3j' /* Your Photos */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, -1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'em9fpiuv' /* Pick your images which show's ... */,
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, .0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Builder(
                              builder: (context) => Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent('EDIT_PROFILE_PAGE_Image_sd7oy3d3_ON_TAP');
                                  logFirebaseEvent('Image_alert_dialog');
                                  await showAlignedDialog(
                                    context: context,
                                    isGlobal: true,
                                    avoidOverflow: false,
                                    targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                    followerAnchor: AlignmentDirectional(0.0, 1.0).resolve(Directionality.of(context)),
                                    builder: (dialogContext) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: GestureDetector(
                                          onTap: () => _model.unfocusNode.canRequestFocus
                                              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                              : FocusScope.of(context).unfocus(),
                                          child: DeleteMediaWidget(
                                            index: 0,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: globalMedia.isNotEmpty && globalMedia.length > 0
                                      ? Image.memory(
                                    globalMedia[0],
                                    width: MediaQuery.of(context).size.width * 0.55,
                                    height: MediaQuery.of(context).size.width * 0.55,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(-1.00, -1.00),
                                  )
                                      : EditProfileWidget.mediaList.isNotEmpty
                                      ? Image.network(
                                    buildImageUrl(EditProfileWidget.mediaList[0]),
                                    width: MediaQuery.of(context).size.width * 0.55,
                                    height: MediaQuery.of(context).size.width * 0.55,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(-1.00, -1.00),
                                  )
                                        : Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x28677681),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      height: MediaQuery.of(context).size.width * 0.55,
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          pickImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                imageBuilder(context, 1),
                                imageBuilder(context, 2),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            imageBuilder(context, 3),
                            imageBuilder(context, 4),
                            imageBuilder(context, 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '03vttghv' /* Hold & Drag media to reorder */,
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Inter',
                            fontSize: 13.0,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '4irs4sa9' /* Relationship Goals */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'y0vexnz5' /* Increase compatibility by shar... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      if (EditProfileWidget.dateType.isEmpty) Builder(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_Container_6htnap7t_ON_TAP');
                            logFirebaseEvent('Container_alert_dialog');
                            await showAlignedDialog(
                              context: context,
                              isGlobal: true,
                              avoidOverflow: false,
                              targetAnchor: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              followerAnchor: AlignmentDirectional(0.0, 1.0)
                                  .resolve(Directionality.of(context)),
                              builder: (dialogContext) {
                                return Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () => _model
                                            .unfocusNode.canRequestFocus
                                        ? FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode)
                                        : FocusScope.of(context).unfocus(),
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.45,
                                      width: double.infinity,
                                      child: RelationGoalsComponentWidget(),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Color(0x32000000),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, -1.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'v7oqzt1y' /* Select Your looking for... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (EditProfileWidget.dateType.isNotEmpty) Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 10.0, 15.0, 0.0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_Container_6htnap7t_ON_TAP');
                              logFirebaseEvent('Container_alert_dialog');
                              await showAlignedDialog(
                                context: context,
                                isGlobal: true,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(0.0, 1.0)
                                    .resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () => _model
                                          .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                          .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Container(
                                        height:
                                        MediaQuery.sizeOf(context).height *
                                            0.45,
                                        width: double.infinity,
                                        child: RelationGoalsComponentWidget(),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    EditProfileWidget.dateType.replaceAll('\n', ' '),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '1s6ti4z9' /* My Interests */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'uosnbdm6' /* Get specific, about things you... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      if (EditProfileWidget.interestList.length < 5) InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'EDIT_PROFILE_Container_9pgy9cah_ON_TAP');
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed('IntrestSelection');
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Color(0x32000000),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.00, -1.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 10.0, 20.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'EDIT_PROFILE_PAGE_Text_3udmt5nt_ON_TAP');
                                        logFirebaseEvent('Text_navigate_to');

                                        Navigator.push(context, MaterialPageRoute(builder: (context) => IntrestSelectionWidget()));
                                      },
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'rbl1w4f4' /* Select your Interest */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (EditProfileWidget.interestList.length != 0) Padding(
                        padding:
                        EdgeInsetsDirectional
                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          child: Wrap(
                            direction: Axis.horizontal,
                            clipBehavior: Clip.antiAlias,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runSpacing: 0,
                            children: List.generate(
                              EditProfileWidget.interestList.length,
                                  (index) => InkWell(
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'EDIT_PROFILE_PAGE_Text_3udmt5nt_ON_TAP');
                                      logFirebaseEvent('Text_navigate_to');

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => IntrestSelectionWidget()));
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 5.0, 5.0, 5.0),
                                      child: Card(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                            FlutterFlowTheme.of(context).primary,
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 10.0, 10.0),
                                            child: Text(
                                              EditProfileWidget.interestList[index],
                                              style: FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .override(
                                                fontFamily: 'Inter',
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Align(
                //         alignment: AlignmentDirectional(-1.00, -1.00),
                //         child: Padding(
                //           padding: EdgeInsetsDirectional.fromSTEB(
                //               0.0, 0.0, 0.0, 10.0),
                //           child: Text(
                //             FFLocalizations.of(context).getText(
                //               'm5jpdfnb' /* Food Preferences */,
                //             ),
                //             style: FlutterFlowTheme.of(context)
                //                 .titleLarge
                //                 .override(
                //                   fontFamily: 'Sora',
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //           ),
                //         ),
                //       ),
                //       Align(
                //         alignment: AlignmentDirectional(-1.00, -1.00),
                //         child: Padding(
                //           padding: EdgeInsetsDirectional.fromSTEB(
                //               0.0, 0.0, 0.0, 10.0),
                //           child: Text(
                //             FFLocalizations.of(context).getText(
                //               'x9ft159b' /* Share favorite cuisines, resta... */,
                //             ),
                //             style: FlutterFlowTheme.of(context).labelLarge,
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         splashColor: Colors.transparent,
                //         focusColor: Colors.transparent,
                //         hoverColor: Colors.transparent,
                //         highlightColor: Colors.transparent,
                //         onTap: () async {
                //           logFirebaseEvent(
                //               'EDIT_PROFILE_Container_i06h5dg7_ON_TAP');
                //           logFirebaseEvent('Container_navigate_to');
                //
                //           context.pushNamed('SelectFoodPreferences');
                //         },
                //         child: Container(
                //           width: double.infinity,
                //           decoration: BoxDecoration(
                //             color: Color(0x00FFFFFF),
                //             borderRadius: BorderRadius.circular(20.0),
                //             border: Border.all(
                //               color: Color(0x32000000),
                //               width: 1.0,
                //             ),
                //           ),
                //           child: Padding(
                //             padding: EdgeInsetsDirectional.fromSTEB(
                //                 0.0, 5.0, 0.0, 5.0),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Align(
                //                   alignment: AlignmentDirectional(-1.00, -1.00),
                //                   child: Padding(
                //                     padding: EdgeInsetsDirectional.fromSTEB(
                //                         20.0, 10.0, 20.0, 10.0),
                //                     child: InkWell(
                //                       splashColor: Colors.transparent,
                //                       focusColor: Colors.transparent,
                //                       hoverColor: Colors.transparent,
                //                       highlightColor: Colors.transparent,
                //                       onTap: () async {
                //                         logFirebaseEvent(
                //                             'EDIT_PROFILE_PAGE_Text_ty9i1i4m_ON_TAP');
                //                         logFirebaseEvent('Text_navigate_to');
                //
                //                         context.pushNamed('IntrestSelection');
                //                       },
                //                       child: Text(
                //                         FFLocalizations.of(context).getText(
                //                           'vkdh3j7p' /* Sleect your food preferences */,
                //                         ),
                //                         style: FlutterFlowTheme.of(context)
                //                             .titleMedium
                //                             .override(
                //                               fontFamily: 'Inter',
                //                               color:
                //                                   FlutterFlowTheme.of(context)
                //                                       .primaryText,
                //                               fontSize: 17.0,
                //                               fontWeight: FontWeight.w500,
                //                             ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsetsDirectional.fromSTEB(
                //                       20.0, 0.0, 20.0, 0.0),
                //                   child: Icon(
                //                     Icons.arrow_forward_ios_rounded,
                //                     color: FlutterFlowTheme.of(context)
                //                         .secondaryText,
                //                     size: 15.0,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '6x8lfl5o' /* Written prompts */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '01jy03j1' /* Make your personality stand ou... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: EditProfileWidget.writtenPromptModelList.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Color(0x32000000),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 0.0, 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                            AlignmentDirectional(-1.00, -1.00),
                                            child: Text(
                                              EditProfileWidget.writtenPromptModelList[i].prompt,
                                              style: FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .override(
                                                fontFamily: 'Inter',
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                            AlignmentDirectional(-1.00, -1.00),
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                              child: Text(
                                                  EditProfileWidget.writtenPromptModelList[i].answer,
                                                style: FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PickWrittePromptPage2EnterPromptWidget(
                                          prompt: EditProfileWidget.writtenPromptModelList[i].prompt,
                                          defaultAns: EditProfileWidget.writtenPromptModelList[i].answer,
                                        )));
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (EditProfileWidget.writtenPromptModelList.length < 3) Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_Container_itchvr5p_ON_TAP');
                            logFirebaseEvent('Container_navigate_to');

                            context.pushNamed('PickWrittenpromptPage');
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Color(0x32000000),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, -1.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'vlswrneo' /* Add a prompts */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'rrnk3tap' /* Opening question */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'y2pl59fe' /* See who you with before matchi... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Color(0x00FFFFFF),
                      //     borderRadius: BorderRadius.circular(20.0),
                      //     border: Border.all(
                      //       color: Color(0x32000000),
                      //       width: 1.0,
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsetsDirectional.fromSTEB(
                      //         0.0, 5.0, 0.0, 5.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Align(
                      //           alignment: AlignmentDirectional(-1.00, -1.00),
                      //           child: Container(
                      //             width:
                      //             MediaQuery.sizeOf(context).width * 0.72,
                      //             decoration: BoxDecoration(
                      //               color: Color(0x00FFFFFF),
                      //             ),
                      //             child: Padding(
                      //               padding: EdgeInsetsDirectional.fromSTEB(
                      //                   20.0, 12.0, 0.0, 12.0),
                      //               child: Text(
                      //                 FFLocalizations.of(context).getText(
                      //                   'mn0oci1p' /* What is Your dream dinner part... */,
                      //                 ),
                      //                 style: FlutterFlowTheme.of(context)
                      //                     .titleMedium
                      //                     .override(
                      //                   fontFamily: 'Inter',
                      //                   color: FlutterFlowTheme.of(context)
                      //                       .primaryText,
                      //                   fontSize: 17.0,
                      //                   fontWeight: FontWeight.w500,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsetsDirectional.fromSTEB(
                      //               20.0, 0.0, 20.0, 0.0),
                      //           child: Icon(
                      //             Icons.add,
                      //             color: FlutterFlowTheme.of(context)
                      //                 .secondaryText,
                      //             size: 25.0,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'EDIT_PROFILE_Container_nmwafk90_ON_TAP');
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed('SelectOpeningQuestion');
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Color(0x32000000),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                  MediaQuery.sizeOf(context).width * 0.72,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 8.0, 0.0, 8.0),
                                    child: Text(
                                      EditProfileWidget.openingQuestion == "" ? "Select an Opening Question" : EditProfileWidget.openingQuestion,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons.add,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              't6ds84gx' /* My bio */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'tu6y5om8' /* Write a fun and punchy intro */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color(0x32000000),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 5.0, 10.0, 5.0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: FFLocalizations.of(context).getText(
                                'mhdu3p39' /* A Little bit about you... */,
                              ),
                              hintStyle:
                                  FlutterFlowTheme.of(context).labelMedium,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                            maxLines: 3,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 15.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'bvse35j2' /* My basics */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_PAGE_Row_uly8808z_ON_TAP');
                            logFirebaseEvent('Row_navigate_to');

                            context.pushNamed('ShowSelectWorkOccupationPage');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/suitcase.png',
                                      width: 25.0,
                                      height: 25.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'iwqmt31x' /* Work */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    (EditProfileWidget.basics['work'] == null || EditProfileWidget.basics['work'].isEmpty) ? "Add" : EditProfileWidget.basics['work'][0]?.jobTitle ?? "Add",
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_PAGE_Row_kap8gaze_ON_TAP');
                            logFirebaseEvent('Row_navigate_to');

                            context.pushNamed('ShowSelectEducationPage');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/mortarboard_(2).png',
                                      width: 30.0,
                                      height: 30.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                          "Education",
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    (EditProfileWidget.basics['education'] == null || EditProfileWidget.basics['education'].isEmpty) ? "Add" : EditProfileWidget.basics['education'][0].title,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_PAGE_Row_962m5j6i_ON_TAP');
                            logFirebaseEvent('Row_navigate_to');

                            context.pushNamed('UpdateYourGender');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/male-and-female-signs.png',
                                      width: 30.0,
                                      height: 30.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'hj4sg5me' /* Gender */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    EditProfileWidget.basics['gender']==null ? "Add" : EditProfileWidget.basics['gender'],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_PAGE_Row_u4ic7cfu_ON_TAP');
                            logFirebaseEvent('Row_navigate_to');

                            context.pushNamed(
                              'SelectLocation',
                              queryParameters: {
                                'hintText': serializeParam(
                                  'Search here current location',
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/maps-and-flags.png',
                                      width: 25.0,
                                      height: 25.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '4frwp397' /* Location */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    EditProfileWidget.basics['location']==null ? "Add" : EditProfileWidget.basics['location'],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_PAGE_Row_l757j14a_ON_TAP');
                            logFirebaseEvent('Row_navigate_to');

                            context.pushNamed(
                              'SelectLocation',
                              queryParameters: {
                                'hintText': serializeParam(
                                  'Search here hometown',
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/home.png',
                                      width: 25.0,
                                      height: 25.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'sblqxn7k' /* Hometown */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    EditProfileWidget.basics['hometown']==null ? "Add" : EditProfileWidget.basics['hometown'],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '2sn7h4q0' /* Add More info. to get best mat... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 15.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'yzwgo6vg' /* Cover the following most propl... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              context.pushNamed('EnterYourHeight');
                            },
                            text: FFLocalizations.of(context).getText(
                              'bqtvk8cj' /* Get Started */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_4v5naqcc_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterYourHeight');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/ruler.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'jle0y7b5' /* Height */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'wulzplbp' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_cpbvrprv_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterExercise');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/weights.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'yx9sou4s' /* Exercise */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'vebu5i2z' /* DPU 2026 */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_0jf8limy_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterEducationLevel');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/mortarboard.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'iyn9z27x' /* Education level */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'kjl00i1z' /* Men */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_yqz7tsmn_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterDrink');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/drink.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'cn00o97c' /* Drinking */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '9bduyjsa' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_b8p1qc1v_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterSmoke');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/cigarette.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'fmajyimf' /* Smoking */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'b74f6t2f' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_as1orne8_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterKids');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/feeding-bottle.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'lh4vwo42' /* Kids */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '3b1i7otq' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_shu4ivx9_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterStarSign');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/star.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '4ura7xzq' /* Star sign */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '0rnz35uf' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_scop7qzr_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterPolitics');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/politics.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'n20dqjia' /* Politics */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '749wqrbd' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_PROFILE_PAGE_Row_y1yund9d_ON_TAP');
                              logFirebaseEvent('Row_navigate_to');

                              context.pushNamed('EnterReligion');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/pray.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 5.0, 20.0, 5.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '1u8hiilh' /* Religion */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'ooy7ipvm' /* Add */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (true == false)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.00, -1.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '96vqavod' /* My pronouns */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.00, -1.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'md3lwf20' /* Be you on Dazel and pick your ... */,
                              ),
                              style: FlutterFlowTheme.of(context).labelLarge,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EDIT_PROFILE_Container_yyeu2qnx_ON_TAP');
                            logFirebaseEvent('Container_navigate_to');

                            context.pushNamed('PickYourGenderPronounsPage');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Color(0x32000000),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 5.0, 20.0, 5.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '1pkv0u82' /* Add your pronouns */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Color(0x32000000),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.00, -1.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 5.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFE1E1),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 10.0, 15.0, 10.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'll5hmtn6' /* she/her */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.00, -1.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 5.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFE1E1),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 10.0, 15.0, 10.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '4v83klyr' /* he/him */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'cmgu077c' /* Languages I know */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      if (EditProfileWidget.languagesList.length < 5) InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'EDIT_PROFILE_Container_7ivf5se6_ON_TAP');
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed('LanguagesIKnow');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Color(0x32000000),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.00, 0.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 5.0, 20.0, 5.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'u4rlyj45' /* Choose the language you know */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (EditProfileWidget.languagesList.isNotEmpty) InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'EDIT_PROFILE_Container_y45iqdfm_ON_TAP');
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed('LanguagesIKnow');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 5.0),
                          child: Wrap(
                            direction: Axis.horizontal,
                            clipBehavior: Clip.antiAlias,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runSpacing: 5,
                            children: List.generate(
                              EditProfileWidget.languagesList.length,
                                  (index) => FittedBox(
                                    fit: BoxFit.contain,
                                    child: Align(
                                      alignment: AlignmentDirectional(-1.00, -1.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                        child: Card(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          ),
                                          child: Align(
                                            alignment:
                                            AlignmentDirectional(-1.00, -1.00),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context)
                                                    .primary,
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 10.0, 10.0),
                                                child: Text(
                                                  EditProfileWidget.languagesList[index],
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .titleMedium
                                                      .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryBackground,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ).py(10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'r97m0eki' /* Connected accounts */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '5c1p9jvr' /* Show off your music & your lat... */,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Color(0x32000000),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/instagram_logo_2022_freelogovectors.net_.webp',
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'u4jnt5gc' /* Connect to instagram */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 10.0, 0.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => InstagramLoginScreen()));
                                      },
                                      icon: Icon(
                                        Icons.circle_outlined,
                                        color: Color(0xFFDD2A7B),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'hi0uvzrz' /* Connecting your instagram will... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 7.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width: 85.0,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 1.00),
                                              child: Container(
                                                width: 75.0,
                                                height: 75.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, -1.00),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD0D0D0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width: 85.0,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 1.00),
                                              child: Container(
                                                width: 75.0,
                                                height: 75.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, -1.00),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD0D0D0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width: 85.0,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 1.00),
                                              child: Container(
                                                width: 75.0,
                                                height: 75.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, -1.00),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD0D0D0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width: 85.0,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 1.00),
                                              child: Container(
                                                width: 75.0,
                                                height: 75.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, -1.00),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD0D0D0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width: 85.0,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 1.00),
                                              child: Container(
                                                width: 75.0,
                                                height: 75.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, -1.00),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD0D0D0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 340.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 3.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 1.0,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: EditProfileWidget.instaPosts.length,
                                    itemBuilder: (context, index) {
                                      final post = EditProfileWidget.instaPosts[index];
                                      return Card(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            post['thumbnail_url'] ?? '',
                                            width: 300.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Color(0x32000000),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Spotify_logo_without_text.svg.png',
                                            width: 30.0,
                                            height: 30.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  7.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '4axsl1yd' /* Connect to Spotity */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 15.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                      child: Icon(
                                        Icons.circle_outlined,
                                        color: Color(0xFF1ED760),
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '3vd5e8j6' /* Connecting your top Spotity ar... */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 7.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Container(
                                          width: 82.0,
                                          height: 82.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.00, 1.00),
                                                child: Container(
                                                  width: 75.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0C000000),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, -1.00),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD0D0D0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Container(
                                          width: 82.0,
                                          height: 82.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.00, 1.00),
                                                child: Container(
                                                  width: 75.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0C000000),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, -1.00),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD0D0D0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Container(
                                          width: 82.0,
                                          height: 82.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.00, 1.00),
                                                child: Container(
                                                  width: 75.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0C000000),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, -1.00),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD0D0D0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Container(
                                          width: 82.0,
                                          height: 82.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.00, 1.00),
                                                child: Container(
                                                  width: 75.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0C000000),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, -1.00),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD0D0D0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Container(
                                          width: 82.0,
                                          height: 82.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.00, 1.00),
                                                child: Container(
                                                  width: 75.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0C000000),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, -1.00),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD0D0D0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, -1.00),
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    'https://picsum.photos/seed/552/600',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 7.0, 10.0, 7.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'miuwxgi6' /* Arjit Singh */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, -1.00),
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    'https://picsum.photos/seed/552/600',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 7.0, 10.0, 7.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'c6z8pz3w' /* Emiway */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .addToStart(SizedBox(width: 10.0))
                                      .addToEnd(SizedBox(width: 10.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageBuilder(context, index) {
    if (globalMedia.isNotEmpty) {
      // Case 1: Local file is available in globalMedia list
      try {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: InkWell(
            onTap: () async {
              logFirebaseEvent('EDIT_PROFILE_PAGE_Image_tmx3lz1s_ON_TAP');
              logFirebaseEvent('Image_alert_dialog');
              await showAlignedDialog(
                context: context,
                isGlobal: true,
                avoidOverflow: false,
                targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(
                    Directionality.of(context)),
                followerAnchor: AlignmentDirectional(0.0, 1.0).resolve(
                    Directionality.of(context)),
                builder: (dialogContext) {
                  return Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () =>
                      _model.unfocusNode.canRequestFocus
                          ? FocusScope.of(context).requestFocus(
                          _model.unfocusNode)
                          : FocusScope.of(context).unfocus(),
                      child: DeleteMediaWidget(index: index),
                    ),
                  );
                },
              ).then((value) => setState(() {}));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.memory(
                globalMedia[index],
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.27,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.27,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      } catch (e) {
        return ButtonForImageSelect();
      }
    } else if (EditProfileWidget.mediaList.isNotEmpty && index < EditProfileWidget.mediaList.length) {
      // Case 2: URL is available in EditProfileWidget.mediaList
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
        child: InkWell(
          onTap: () async {
            logFirebaseEvent('EDIT_PROFILE_PAGE_Image_tmx3lz1s_ON_TAP');
            logFirebaseEvent('Image_alert_dialog');
            await showAlignedDialog(
              context: context,
              isGlobal: true,
              avoidOverflow: false,
              targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
              followerAnchor: AlignmentDirectional(0.0, 1.0).resolve(Directionality.of(context)),
              builder: (dialogContext) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => _model.unfocusNode.canRequestFocus
                        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                        : FocusScope.of(context).unfocus(),
                    child: DeleteMediaWidget(index: index),
                  ),
                );
              },
            ).then((value) => setState(() {}));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              buildImageUrl(EditProfileWidget.mediaList[index]),
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.width * 0.27,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      // Case 3: Show Add button if no local file or URL is available at the specified index
      return ButtonForImageSelect();
    }
  }
  Widget ButtonForImageSelect() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
      child: InkWell(
        onTap: () async {
          logFirebaseEvent('EDIT_PROFILE_Container_btd9rzih_ON_TAP');
          logFirebaseEvent('Container_alert_dialog');
          await showAlignedDialog(
            context: context,
            isGlobal: true,
            avoidOverflow: false,
            targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
            followerAnchor: AlignmentDirectional(0.0, 1.0).resolve(Directionality.of(context)),
            builder: (dialogContext) {
              return Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: SelectProfileMediaWidget(),
                ),
              );
            },
          ).then((value) => setState(() {}));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.width * 0.27,
          decoration: BoxDecoration(
            color: Color(0x28677681),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FlutterFlowIconButton(
            borderColor: Color(0x00F83B46),
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: Color(0x00F83B46),
            icon: Icon(
              Icons.add,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30.0,
            ),
            onPressed: () {
              pickImage();
            },
          ),
        ),
      ),
    );
  }
}
