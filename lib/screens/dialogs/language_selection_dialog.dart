import 'package:flutter/material.dart';
import 'package:purena_lemo/services/translation_service.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageSelected;

  const LanguageSelectionDialog({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(TranslationService.getTranslation(
          currentLanguage, "choose_language")),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onLanguageSelected('Polski');
          },
          child: const Text('Polski'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onLanguageSelected('English');
          },
          child: const Text('English'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onLanguageSelected('Italiano');
          },
          child: const Text('Italiano'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onLanguageSelected('Czech');
          },
          child: const Text('Czech'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onLanguageSelected('Dutch');
          },
          child: const Text('Dutch'),
        ),
      ],
    );
  }
}
