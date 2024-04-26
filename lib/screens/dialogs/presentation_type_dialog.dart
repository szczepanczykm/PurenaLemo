import 'package:flutter/material.dart';
import 'package:purena_lemo/constants/enums.dart';
import 'package:purena_lemo/constants/maps.dart';
import 'package:purena_lemo/services/translation_service.dart';

class PresentationTypeDialog extends StatelessWidget {
  final String currentLanguage;
  final PresentationType initialPresentationType;
  final Function(PresentationType) onPresentationTypeSelected;

  const PresentationTypeDialog({
    super.key,
    required this.currentLanguage,
    required this.initialPresentationType,
    required this.onPresentationTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(TranslationService.getTranslation(
          currentLanguage, "choose_presentation_type")),
      children: PresentationType.values.map((type) {
        return SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onPresentationTypeSelected(type);
          },
          child: Text(presentationTypeNames[type] ?? 'Undefined'),
        );
      }).toList(),
    );
  }
}
