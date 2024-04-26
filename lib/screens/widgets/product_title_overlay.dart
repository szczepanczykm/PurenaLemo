import 'package:flutter/material.dart';

import '../../constants/enums.dart';

class ProductTitleOverlay extends StatelessWidget {
  const ProductTitleOverlay(
      {super.key,
      required this.text,
      this.textColor = Colors.white,
      required this.presentationType});

  final String text;
  final Color textColor;
  final PresentationType presentationType;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (presentationType == PresentationType.type1) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 120, bottom: 30),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        );
      } else if (presentationType == PresentationType.type2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: constraints.maxHeight / 4),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: constraints.maxHeight / 2.2),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
