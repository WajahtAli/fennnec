import 'package:intl/intl.dart';

int validateInt(var data) {
  try {
    if (data != null && data is int) {
      return data;
    } else if (data is String) {
      return int.parse(data);
    } else if (data is double) {
      return data.toInt();
    }
  } catch (e) {
    return 0;
  }
  return 0;
}

String validateString(var data) {
  try {
    if (data == null) {
      return "";
    }
    if (data is String) {
      return data;
    } else {
      return "$data";
    }
  } catch (e) {
    return "";
  }
}

double validateDouble(var data) {
  try {
    if (data != null && data is double) {
      return data;
    } else if (data is String) {
      return double.parse(data);
    } else if (data is int) {
      return data.toDouble();
    }
  } catch (e) {
    return 0.00;
  }
  return 0.00;
}

bool validateBool(var data) {
  try {
    if (data != null && data is bool) {
      return data;
    } else if (data is String) {
      if (data == "true") {
        return true;
      } else {
        return false;
      }
    } else if (data is int) {
      if (data > 0) {
        return true;
      } else {
        return false;
      }
    }
  } catch (e) {
    return false;
  }
  return false;
}

List<String> validateStringList(List<String?> input) {
  return input.whereType<String>().toList();
}

final nameRegex = RegExp(
  r'^[a-zA-Z ]+$|^[\u0600-\u06FF ]+$|^[\u0980-\u09FF ]+$',
);

bool isValidName(String? name) {
  var data = nameRegex.hasMatch(name ?? "");
  return data;
}

// Egyptian National ID = 14 digits
final RegExp nationalIdPattern = RegExp(r'^[0-9]{10}$');

// Date format DD/MM/YYYY
final RegExp dobPattern = RegExp(
  r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
);

bool isValidNationalId(String id) {
  return nationalIdPattern.hasMatch(id);
}

bool isValidDOB(String dob) {
  return dobPattern.hasMatch(dob);
}

String formatDOB(String input) {
  input = input.replaceAll(RegExp(r'[^0-9]'), '');

  if (input.length >= 3 && input.length <= 4) {
    return "${input.substring(0, 2)}/${input.substring(2)}";
  } else if (input.length >= 5) {
    return "${input.substring(0, 2)}/${input.substring(2, 4)}/${input.substring(4, input.length > 8 ? 8 : input.length)}";
  }
  return input;
}

// validate email
final RegExp emailPattern = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

bool isValidEmail(String email) {
  return emailPattern.hasMatch(email);
}

String normalizePhone(String phone) {
  return phone.replaceAll(RegExp(r'\s+'), '');
}

String formatDate(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } catch (e) {
    return '';
  }
}

String calculateAge(String dateOfBirth) {
  if (dateOfBirth.isEmpty) return "";
  DateTime dob = DateTime.tryParse(dateOfBirth) ?? DateTime.now();
  DateTime today = DateTime.now();

  int age = today.year - dob.year;

  if (today.month < dob.month ||
      (today.month == dob.month && today.day < dob.day)) {
    age--;
  }

  return age > 0 ? age.toString() : "";
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}
