import 'package:flutter/material.dart';
import 'package:purena_lemo/services/translation_service.dart';

import '../../models/portion_state.dart';
import '../widgets/settings_row.dart';

class SettingsDialog extends StatefulWidget {
  final List<PortionState> portionStates;
  final List<TextEditingController> quantityControllers;
  final List<TextEditingController> priceControllers;
  final Function(List<PortionState>) onSave;
  final String currentLanguage;

  const SettingsDialog({
    super.key,
    required this.portionStates,
    required this.quantityControllers,
    required this.priceControllers,
    required this.onSave,
    required this.currentLanguage,
  });

  @override
  SettingsDialogState createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  late List<bool> localIsChecked;

  @override
  void initState() {
    super.initState();
    localIsChecked = [
      widget.portionStates[0].isChecked,
      widget.portionStates[1].isChecked,
      widget.portionStates[2].isChecked,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(TranslationService.getTranslation(
          widget.currentLanguage, "set_parameters")),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SettingsRow(
              rowNumber: 0,
              isChecked: localIsChecked[0],
              onCheckedChanged: (bool? value) {
                setState(() {
                  localIsChecked[0] = value ?? localIsChecked[0];
                });
              },
              quantityController: widget.quantityControllers[0],
              priceController: widget.priceControllers[0],
            ),
            SettingsRow(
              rowNumber: 1,
              isChecked: localIsChecked[1],
              onCheckedChanged: (bool? value) {
                setState(() {
                  localIsChecked[1] = value ?? localIsChecked[1];
                });
              },
              quantityController: widget.quantityControllers[1],
              priceController: widget.priceControllers[1],
            ),
            SettingsRow(
              rowNumber: 2,
              isChecked: localIsChecked[2],
              onCheckedChanged: (bool? value) {
                setState(() {
                  localIsChecked[2] = value ?? localIsChecked[2];
                });
              },
              quantityController: widget.quantityControllers[2],
              priceController: widget.priceControllers[2],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Anuluj'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Zapisz'),
          onPressed: () {
            List<PortionState> updatedPortionStates =
                List.from(widget.portionStates);
            for (int i = 0; i < updatedPortionStates.length; i++) {
              updatedPortionStates[i].quantity =
                  widget.quantityControllers[i].text.isNotEmpty
                      ? widget.quantityControllers[i].text
                      : updatedPortionStates[i].quantity;
              updatedPortionStates[i].price =
                  widget.priceControllers[i].text.isNotEmpty
                      ? widget.priceControllers[i].text
                      : updatedPortionStates[i].price;
              updatedPortionStates[i].isChecked = localIsChecked[i];
            }
            widget.onSave(updatedPortionStates);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
