import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purena_lemo/screens/widgets/video_widget.dart';
import 'package:video_player/video_player.dart';

import '../constants/enums.dart';

class FullScreenVideoScreen extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final String productTitleText;
  final List<Map<String, dynamic>> selectedPortions;
  final PresentationType presentationType;

  const FullScreenVideoScreen({
    super.key,
    required this.controller,
    this.textColor = Colors.white,
    this.productTitleText = '',
    required this.selectedPortions,
    required this.presentationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: SystemUiOverlay.values);
          }
        },
        child: VideoWidget(
          controller: controller,
          textColor: textColor,
          text: productTitleText,
          selectedPortions: selectedPortions,
          presentationType: presentationType,
        ),
      ),
    );
  }
}
