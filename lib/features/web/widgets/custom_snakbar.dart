import 'package:flutter/material.dart';
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/snackify.dart';
import 'package:snackify/tts_config.dart';

void showCustomSnakcbar(
  BuildContext context,
  String title,
  String subTitle,
  Gradient gradient,
  SnackType type,
  SnackPosition position,
) {
  Snackify.show(
    context: context,
    type: type,
    title: Text(title),
    subtitle: Text(subTitle),
    ttsConfig: TTSConfiguration(speakOnShow: true),
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 500),
    backgroundGradient: gradient,
    position: position,
    persistent:
        false, // Set to true to keep Snackbar visible until manually dismissed
  );
}
