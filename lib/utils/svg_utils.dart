import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget getSvgPicture(String logoPath) {
  var semanticsLabel = 'Purena Logo';
  var fitType = BoxFit.fitWidth;
  var height = 100.0;

  var svgExtension = ".svg";
  var pngExtension = ".png";
  if (logoPath.startsWith('assets/')) {
    if (logoPath.endsWith(svgExtension)) {
      return SvgPicture.asset(
        logoPath,
        semanticsLabel: semanticsLabel,
        height: height,
        fit: fitType,
      );
    } else if (logoPath.endsWith(pngExtension)) {
      return Image.asset(
        logoPath,
        height: height,
        fit: fitType,
      );
    }
  } else if (logoPath.startsWith('http')) {
    if (logoPath.endsWith(svgExtension)) {
      return SvgPicture.network(
        logoPath,
        semanticsLabel: semanticsLabel,
        height: height,
        fit: fitType,
      );
    } else if (logoPath.endsWith(pngExtension)) {
      return Image.network(
        logoPath,
        height: height,
        fit: fitType,
      );
    }
  } else if (logoPath.startsWith('/')) {
    if (logoPath.endsWith(svgExtension)) {
      return SvgPicture.file(
        File(logoPath),
        semanticsLabel: semanticsLabel,
        height: height,
        fit: fitType,
      );
    } else if (logoPath.endsWith(pngExtension)) {
      return Image.file(
        File(logoPath),
        height: height,
        fit: fitType,
      );
    }
  }
  return SvgPicture.asset(
    'assets/images/logo_purena.svg',
    semanticsLabel: semanticsLabel,
    height: height,
    fit: fitType,
  );
}
