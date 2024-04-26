import 'package:flutter/material.dart';
import 'package:purena_lemo/screens/widgets/product_prices_overlay.dart';
import 'package:purena_lemo/screens/widgets/product_title_overlay.dart';
import 'package:video_player/video_player.dart';

import '../../constants/enums.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget(
      {super.key,
      required this.controller,
      required this.textColor,
      required this.text,
      required this.selectedPortions,
      required this.presentationType});

  final VideoPlayerController controller;
  final Color textColor;
  final String text;
  final List<Map<String, dynamic>> selectedPortions;
  final PresentationType presentationType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        controller.value.isInitialized
            ? VideoPlayer(controller)
            : const CircularProgressIndicator(),
        ProductPricesOverlayWidget(
          controller: controller,
          textColor: textColor,
          selectedPortions: selectedPortions,
          presentationType: presentationType,
        ),
        ProductTitleOverlay(
          text: text,
          textColor: textColor,
          presentationType: presentationType,
        ),
      ],
    );
  }
}
