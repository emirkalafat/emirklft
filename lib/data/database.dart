import 'package:flutter/material.dart';

Map<String, String> links = {
  'GitHub': 'https://github.com/emirkalafat',
  'LinkedIn': 'https://www.linkedin.com/in/emir-kalafat/',
  //'Twitter': '',
  'Instagram': 'https://www.secure.instagram.com/garlicmanklft/',
  'Youtube': 'https://www.youtube.com/channel/UCg2As3couk4eZztAgNfowPQ',
};

List<dynamic> linkImages = [];

Map<String, double> skills = {
  'Dart - Flutter': 0.80,
  'C': 0.75,
  'Java': 0.60,
  'Python': 0.60,
  'Unity - C#': 0.50,
};
List<dynamic> skillImages = [
  const FlutterLogo(size: 50),
  Image.asset(
    'assets/skills/c.png',
    height: 50,
  ),
  Image.asset(
    'assets/skills/java.png',
    height: 50,
  ),
  Image.asset(
    'assets/skills/python.png',
    height: 50,
  ),
  Image.asset(
    'assets/skills/unity.png',
    height: 50,
  ),
];
