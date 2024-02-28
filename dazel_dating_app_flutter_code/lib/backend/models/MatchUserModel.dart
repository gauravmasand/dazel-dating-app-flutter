class MatchedUserModel {
  final String id;
  final String name;
  final List<String> media;

  MatchedUserModel({
    required this.id,
    required this.name,
    required this.media,
  });

  factory MatchedUserModel.fromJson(Map<String, dynamic> json) {
    return MatchedUserModel(
      id: json['_id'],
      name: json['name'],
      media: List<String>.from(json['media']),
    );
  }
}