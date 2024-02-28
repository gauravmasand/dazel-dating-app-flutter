import '../flutter_flow/flutter_flow_util.dart';
import 'Constants.dart';
import 'dart:math';

String calculateAge(String dobString) {
  // Split the string into day, month, and year components
  List<String> dobParts = dobString.split('/');
  int day = int.parse(dobParts[0]);
  int month = int.parse(dobParts[1]);
  int year = int.parse(dobParts[2]);

  // Get the current date
  DateTime now = DateTime.now();

  // Calculate the age
  int age = now.year - year;
  if (now.month < month || (now.month == month && now.day < day)) {
    age--;
  }
  return age.toString();
}

String buildImageUrl(String imageName) {
  return '${Constants.url}/api/fetch/userImage/$imageName';
}

String buildChatMediaUrl(String imageName) {
  return '${Constants.url}/api/fetch/userMediaOfChat/$imageName';
}

String standardizePhoneNumber(String phoneNumber) {
  // Remove special characters from the phone number
  String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[()\s-]'), '');

  // If the number starts with '91', consider it complete
  if (cleanedNumber.startsWith('91')) {
    return '+$cleanedNumber';
  }

  // If the number starts with '0', replace it with '91'
  if (cleanedNumber.startsWith('0')) {
    cleanedNumber = '91' + cleanedNumber.substring(1);
  }

  // If the number length is less than 10 after cleaning, it might not be valid
  if (cleanedNumber.length < 10) {
    return 'Invalid phone number';
  }

  // If the number starts with a '+' sign, assume it's already in the correct format
  if (cleanedNumber.startsWith('+')) {
    return cleanedNumber;
  }

  // If the number is of valid length, prefix with '+91'
  return '+91' + cleanedNumber.substring(cleanedNumber.length - 10);
}

double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
    ) {
  const double earthRadius = 6371.0; // Earth radius in kilometers

  // Convert latitude and longitude from degrees to radians
  final double startLatRad = _radians(startLatitude);
  final double startLonRad = _radians(startLongitude);
  final double endLatRad = _radians(endLatitude);
  final double endLonRad = _radians(endLongitude);

  // Calculate the change in coordinates
  final double latDiff = endLatRad - startLatRad;
  final double lonDiff = endLonRad - startLonRad;

  // Haversine formula to calculate distance
  final double a = sin(latDiff / 2) * sin(latDiff / 2) +
      cos(startLatRad) * cos(endLatRad) * sin(lonDiff / 2) * sin(lonDiff / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c;

  // If distance is less than 1 kilometer, convert to meters
  if (distance < 1.0) {
    return distance * 1000.0; // Convert to meters
  }

  return distance;
}

double _radians(double degrees) {
  return degrees * (pi / 180.0);
}

String formatTimestamp(String timestamp) {
  DateTime parsedTime = DateTime.parse(timestamp).toLocal(); // Convert to local time

  DateTime now = DateTime.now().toLocal(); // Convert to local time
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (parsedTime.isAfter(now)) {
    // Show in AM/PM format
    return DateFormat.jm().format(parsedTime);
  } else if (parsedTime.isAfter(yesterday)) {
    // Show "Yesterday" for timestamps from yesterday
    return 'Yesterday';
  } else if (parsedTime.year == now.year) {
    // Show month and day for timestamps from the current year
    return DateFormat('MMM d').format(parsedTime);
  } else {
    // Show year, month, and day for older timestamps
    return DateFormat('yyyy MMM d').format(parsedTime);
  }
}

String makeOnlineStatusFromString(String timestampString) {
  DateTime now = DateTime.now();
  DateTime lastActive = DateTime.parse(timestampString);

  // Calculate the time difference in seconds
  int differenceInSeconds = now.difference(lastActive).inSeconds;

  if (differenceInSeconds <= 5) {
    return 'Online'; // User is currently online
  } else if (differenceInSeconds < 60) {
    return 'Last seen ${differenceInSeconds}s ago'; // User was online within the last minute
  } else if (differenceInSeconds < 60 * 60) {
    int minutes = differenceInSeconds ~/ 60;
    return 'Last seen ${minutes}m ago'; // User was online within the last hour
  } else if (differenceInSeconds < 24 * 60 * 60) {
    int hours = differenceInSeconds ~/ (60 * 60);
    return 'Last seen ${hours}h ago'; // User was online within the last day
  } else if (differenceInSeconds < 7 * 24 * 60 * 60) {
    int days = differenceInSeconds ~/ (7 * 24 * 60 * 60);
    return 'Last seen ${days}d ago'; // User was online within the last week
  } else {
    return 'Offline'; // User was online more than a week ago
  }
}

int calculateTimeDifferenceInMinutes(int timestampMilliseconds) {
  if (timestampMilliseconds < 0) {
    // Handling negative input (if needed)
    return 0;
  }

  DateTime currentTime = DateTime.now();
  DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(timestampMilliseconds);

  Duration difference = currentTime.difference(timestamp);
  int minutesDifference = difference.inMinutes;

  return minutesDifference;
}