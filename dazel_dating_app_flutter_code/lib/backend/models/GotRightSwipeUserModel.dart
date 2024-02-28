import 'dart:convert';

class GotRightSwipeUserModel {
  final String id;
  final String name;
  final List<String> media;
  final Map? message;
  final String dob;
  final bool isOnline;

  GotRightSwipeUserModel({
    required this.id,
    required this.name,
    required this.media,
    this.message,
    required this.dob,
    required this.isOnline,
  });

  factory GotRightSwipeUserModel.fromJson(Map<String, dynamic> json) {
    return GotRightSwipeUserModel(
      id: json['_id'],
      name: json['name'],
      dob: json['dob'],
      media: List<String>.from(json['media']),
      message: jsonDecode(json['message']),
      isOnline: json['isOnline'],
    );
  }
}