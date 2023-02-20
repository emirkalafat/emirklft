import 'package:flutter/material.dart';

const backgroundGradient = RadialGradient(
  colors: [
    Color.fromARGB(171, 56, 255, 238),
    Color.fromARGB(255, 0, 185, 25),
    Color.fromARGB(255, 0, 81, 255),
  ],
  focalRadius: 1.5,
  center: Alignment(1, -1),
  focal: Alignment(0.5, -0.2),
);
