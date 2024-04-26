import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'models/logo_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LogoState(),
      child: const MyApp(),
    ),
  );
}
