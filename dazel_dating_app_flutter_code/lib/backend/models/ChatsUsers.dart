import 'dart:convert';

class ChatsUsersModel {
  String receiverId;
  String name;
  List<dynamic> media;
  int unseenMessages;
  Map mostRecentMessage;
  String? mostRecentMessageTime;

  ChatsUsersModel({
    required this.receiverId,
    required this.name,
    required this.media,
    required this.unseenMessages,
    required this.mostRecentMessage,
    required this.mostRecentMessageTime,
  });

  factory ChatsUsersModel.fromJson(Map<String, dynamic> json) {
    return ChatsUsersModel(
      receiverId: json['receiverId'],
      name: json['name'],
      media: List.from(json['media']),
      unseenMessages: json['unseenMessages'],
      mostRecentMessage: jsonDecode(json['mostRecentMessage']),
      mostRecentMessageTime: json['mostRecentMessageTime'],
    );
  }


  // Rename this constructor to correctly match the model
  factory ChatsUsersModel.fromApiResponse(Map<String, dynamic> json) {
    return ChatsUsersModel.fromJson(json);
  }
}
