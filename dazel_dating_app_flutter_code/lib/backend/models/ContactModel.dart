import 'package:contacts_service/contacts_service.dart';

class ContactModel {
  final String name;
  final List<String> phoneNumbers;
  final List<String> emails;

  ContactModel({
    required this.name,
    required this.phoneNumbers,
    required this.emails,
  });

  factory ContactModel.fromContact(Contact contact) {
    return ContactModel(
      name: contact.displayName ?? '',
      phoneNumbers: contact.phones?.map((phone) => phone.value ?? '').toList() ?? [],
      emails: contact.emails?.map((email) => email.value ?? '').toList() ?? [],
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'] ?? '',
      phoneNumbers: List<String>.from(json['phoneNumbers'] ?? []),
      emails: List<String>.from(json['emails'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumbers': phoneNumbers,
      'emails': emails,
    };
  }
}