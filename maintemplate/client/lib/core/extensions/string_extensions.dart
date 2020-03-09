// import 'package:maintemplate/core/routing/route_data.dart';

extension StringExtension on String {
 
  String get getLanguage {
    if (this == 'en') {
      return 'English';
    }

    if (this == 'es') {
      return 'Spanish';
    }

    if (this == 'fr') {
      return 'French';
    }

    if (this == 'ur') {
      return 'Urdu';
    }

    if (this == 'system') {
      return 'system';
    }
  }
}
