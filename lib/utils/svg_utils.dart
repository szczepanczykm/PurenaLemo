import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget getSvgPicture(String logoPath) {
  if (logoPath.startsWith('assets/') && logoPath.endsWith(".svg")) {
    return SvgPicture.asset(
      logoPath,
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else if (logoPath.startsWith('http') && logoPath.endsWith(".svg")) {
    return SvgPicture.network(
      logoPath,
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else if (logoPath.startsWith('/') && logoPath.endsWith(".svg")) {
    return SvgPicture.file(
      File(logoPath),
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else if (logoPath.startsWith('assets/') && logoPath.endsWith(".png")) {
    return Image.asset(
      logoPath,
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else if (logoPath.startsWith('http') && logoPath.endsWith(".png")) {
    return Image.network(
      logoPath,
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else if (logoPath.startsWith('/') && logoPath.endsWith(".png")) {
    return Image.file(
      File(logoPath),
      height: 100,
      fit: BoxFit.fitWidth,
    );
  } else {
    return SvgPicture.asset(
      'assets/images/logo_purena.svg',
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
}
