import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  bool isSender;
  Map message;
  String timestamp;
  bool seen;
  bool isDoc;
  List<String> docUrls;

  ChatMessage({
    required this.isSender,
    required this.message,
    required this.timestamp,
    this.seen = false,
    this.isDoc = false,
    this.docUrls = const [],
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      isSender: json['isSender'] ?? false,
      message: jsonDecode(json['message']),
      timestamp: json['timestamp'].toString(),
      seen: json['seen'] ?? false,
      isDoc: json['isDoc'] ?? false,
      docUrls: List<String>.from(json['docUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSender': isSender,
      'message': jsonEncode(message),
      'timestamp': timestamp,
      'seen': seen,
      'isDoc': isDoc,
      'docUrls': docUrls,
    };
  }
}


class ChatStorage {
  static const String keyPrefix = 'user_chat_';

  static Future<void> saveChatMessages(String userId, List<ChatMessage> messages) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> messagesJson = messages.map((message) => message.toJson()).toList();
    await prefs.setStringList(keyPrefix + userId, messagesJson.map((message) => jsonEncode(message)).toList());
  }

  static Future<List<ChatMessage>> getChatMessages(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? messagesJson = prefs.getStringList(keyPrefix + userId);
    if (messagesJson != null) {
      return messagesJson.map((message) => ChatMessage.fromJson(jsonDecode(message))).toList();
    } else {
      return [];
    }
  }
}