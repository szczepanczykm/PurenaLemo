import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../constants/enums.dart';
import '../../models/logo_state.dart';
import '../../models/portion_state.dart';
import '../../utils/svg_utils.dart';

class ProductPricesOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final List<PortionState> selectedPortions;
  final PresentationType presentationType;

  const ProductPricesOverlayWidget(
      {super.key,
      required this.controller,
      required this.textColor,
      required this.selectedPortions,
      required this.presentationType});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (presentationType == PresentationType.type1) {
        double iconSize = constraints.maxHeight / 7;
        double fontSize = constraints.maxHeight / 23;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(portion.assetPath, portion.quantity,
              portion.price, iconSize, fontSize, textColor);
        }).toList();

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: getSvgPicture(
                      Provider.of<LogoState>(context).logoUrl),
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: productSizeColumns
                      .map((w) => Flexible(child: w))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      } else if (presentationType == PresentationType.type2) {
        double imageSize = constraints.maxHeight / 9;
        double iconSize = constraints.maxHeight / 10;
        double fontSize = constraints.maxHeight / 28;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(portion.assetPath, portion.quantity,
              portion.price, iconSize, fontSize, textColor);
        }).toList();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: imageSize / 3),
                child: getSvgPicture(Provider.of<LogoState>(context).logoUrl),
              ),
              Container(
                height: imageSize * 2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      } else {
        double imageSize = constraints.maxHeight / 5;
        double iconSize = constraints.maxHeight / 4;
        double fontSize = constraints.maxHeight / 21;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(portion.assetPath, portion.quantity,
              portion.price, iconSize, fontSize, textColor);
        }).toList();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: imageSize / 3),
                child: getSvgPicture(Provider.of<LogoState>(context).logoUrl),
              ),
              Container(
                height: imageSize * 2,
                color: Colors.white.withOpacity(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Column buildProductSizeColumn(String assetPath, String sizeText,
      String priceText, double iconSize, double fontSize, Color currentColor) {
    TextStyle adjustedTextStyle = TextStyle(
      color: currentColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto Mono',
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: SvgPicture.asset(assetPath, height: iconSize)),
        AutoSizeText(
          sizeText,
          style: adjustedTextStyle,
          maxLines: 1,
          minFontSize: 6,
        ),
        AutoSizeText(
          priceText,
          style: adjustedTextStyle,
          maxLines: 1,
          minFontSize: 6,
        ),
      ],
    );
  }
}
