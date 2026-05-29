import 'package:flutter/material.dart';

class AppTextSizes {
  static const double display = 34;
  static const double heading = 26;
  static const double subheading = 20;
  static const double body = 16;
  static const double small = 13;
  static const double caption = 11;
}

class AppTextStyles {
  static const TextStyle display = TextStyle(
    fontSize: AppTextSizes.display,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading = TextStyle(
    fontSize: AppTextSizes.heading,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: AppTextSizes.subheading,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle body = TextStyle(
    fontSize: AppTextSizes.body,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static const TextStyle small = TextStyle(
    fontSize: AppTextSizes.small,
    color: Colors.grey,
  );

  static const TextStyle caption = TextStyle(
    fontSize: AppTextSizes.caption,
    color: Colors.grey,
  );
}