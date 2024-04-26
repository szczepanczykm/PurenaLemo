import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  @override
  ColorPickerDialogState createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _pickerColor;

  @override
  void initState() {
    super.initState();
    _pickerColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Wybierz kolor'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _pickerColor,
          onColorChanged: (Color color) {
            setState(() {
              _pickerColor = color;
            });
          },
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.onColorSelected(_pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
