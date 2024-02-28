import '../../pages/edit_profile/edit_profile_widget.dart';

class UserData {
  String id;
   String? email;
   String? phone;
   String? name;
   String? dob;
   String? gender;
   List<String>? media;
   String? typeOfDate;
   List<String>? interests;
   bool? isSpotlight;
   bool? autoSpotlight;
   dynamic? spotlightStartMilliseconds;
   String? bio;
   List<String>? languages;
   List<WorkModel>? work;
   List<EducationModel>? education;
   List<WrittenPromptModel>? writtenPrompts;
   List<String> openingQuestions = [];
   bool? incognitoMode;
   String? signupDateAndTime;
   String? location;
   String? hometown;
   String? latitude;
   String? longitude;
   int? version;

   String? height, doYouWorkout, educationLevel,
      doYouDrink, smoke, havingKids, starSign, politicalLearning,
      religiousBelief;

  UserData({
    required this.id,
    this.email,
    this.phone,
    this.name,
    this.dob,
    this.gender,
    this.media,
    this.typeOfDate,
    this.interests,
    this.isSpotlight,
    this.autoSpotlight,
    this.spotlightStartMilliseconds,
    this.bio,
    this.languages,
    this.work,
    this.education,
    this.location,
    this.height,
    this.doYouWorkout,
    this.educationLevel,
    this.doYouDrink,
    this.smoke,
    this.latitude,
    this.longitude,
    this.havingKids,
    this.starSign,
    this.politicalLearning,
    this.religiousBelief,
    this.hometown,
    this.writtenPrompts,
    required this.openingQuestions,
    this.incognitoMode,
    this.signupDateAndTime,
    this.version,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      email: json['email'],
      phone: json['phoneNumber'],
      name: json['name'],
      dob: json['dob'],
      gender: json['basicInfo']['gender'],
      media: List<String>.from(json['media']),
      typeOfDate: json['typeOfDate'],
      interests: List<String>.from(json['interests']),
      isSpotlight: json['spotlight']['isSpotlight'],
      autoSpotlight: json['spotlight']['autoSpotlight'],
      spotlightStartMilliseconds: json['spotlight']['startMilliseconds'],
      bio: json['bio'],
      hometown: json['basicInfo']['hometown'],
      location: json['basicInfo']['location'],
      latitude: json['realtimeUserLocation']['latitude'],
      longitude: json['realtimeUserLocation']['longitude'],
      height: json['moreAboutUser']['height']?.toString(),
      doYouDrink: json['moreAboutUser']['doYouDrink'],
      doYouWorkout: json['moreAboutUser']['doYouWorkout'],
      educationLevel: json['moreAboutUser']['educationLevel'],
      havingKids: json['moreAboutUser']['havingKids'],
      politicalLearning: json['moreAboutUser']['politicalLearning'],
      religiousBelief: json['moreAboutUser']['religiousBelief'],
      smoke: json['moreAboutUser']['smoke'],
      starSign: json['moreAboutUser']['starSign'],

      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      work: (json['basicInfo']['work'] as List<dynamic>?)
          ?.map((workData) => WorkModel.fromJson(workData))
          .toList(),
      education: (json['basicInfo']['education'] as List<dynamic>?)
          ?.map((eduData) => EducationModel.fromJson(eduData))
          .toList(),
      writtenPrompts: (json['writtenPrompts'] as List<dynamic>?)
          ?.map((promptData) => WrittenPromptModel.fromJson(promptData))
          .toList(),
      openingQuestions: List<String>.from(json['openingQuestions']),
      incognitoMode: json['incognitoMode'],
      signupDateAndTime: json['signupDateAndTime'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'phoneNumber': phone,
      'name': name,
      'dob': dob,
      'basicInfo': {
        'gender': gender,
        'work': work?.map((workItem) => workItem.toJson()).toList(),
        'education': education?.map((eduItem) => eduItem.toJson()).toList(),
        'location': location,
        'hometown': hometown,
      },
      'moreAboutUser': {
        'height': height,
        'doYouWorkout': doYouWorkout,
        'educationLevel': educationLevel,
        'doYouDrink': doYouDrink,
        'smoke': doYouDrink,
        'havingKids': havingKids,
        'starSign': starSign,
        'politicalLearning': politicalLearning,
        'religiousBelief': religiousBelief
      },
      'media': media,
      'typeOfDate': typeOfDate,
      'interests': interests,
      'spotlight': {
        'isSpotlight': isSpotlight,
        'autoSpotlight': autoSpotlight,
        'startMilliseconds': spotlightStartMilliseconds,
      },
      'bio': bio,
      'languages': languages,
      'writtenPrompts':
      writtenPrompts?.map((promptItem) => promptItem.toJson()).toList(),
      'openingQuestions': openingQuestions,
      'incognitoMode': incognitoMode,
      'signupDateAndTime': signupDateAndTime,
      '__v': version,
    };
  }

  String getId() {
    return id;
  }

  String? getEmail() {
    return email ?? "";
  }

  String? getPhone() {
    return phone ?? "";
  }

  String? getName() {
    return name ?? "";
  }

  String? getDOB() {
    return dob ?? "";
  }

  String? getGender() {
    return gender ?? "";
  }

  List<String>? getMedia() {
    return media ?? [];
  }

  String? getTypeOfDate() {
    return typeOfDate ?? "";
  }

  List<String>? getInterests() {
    return interests ?? [];
  }

  bool? getIsSpotlight() {
    return isSpotlight ?? false;
  }

  String? getSpotlightStartMilliseconds() {
    return spotlightStartMilliseconds ?? "";
  }

  String? getBio() {
    return bio ?? "";
  }

  List<String>? getLanguages() {
    return languages ?? [];
  }

  String? getSignupDateAndTime() {
    return signupDateAndTime ?? "";
  }

  List<WorkModel>? getWork() {
    return work ?? [];
  }

  List<EducationModel>? getEducation() {
    return education ?? [];
  }

  List<WrittenPromptModel>? getWrittenPrompt() {
    return writtenPrompts ?? [];
  }
}