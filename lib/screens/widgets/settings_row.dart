import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  final int rowNumber;
  final bool isChecked;
  final Function(bool?) onCheckedChanged;
  final TextEditingController quantityController;
  final TextEditingController priceController;

  const SettingsRow({
    super.key,
    required this.rowNumber,
    required this.isChecked,
    required this.onCheckedChanged,
    required this.quantityController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    String portionTitle = "${rowNumber + 1}.";

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(portionTitle, textAlign: TextAlign.right),
        ),
        Checkbox(
          value: isChecked,
          onChanged: onCheckedChanged,
        ),
        Expanded(
          flex: 3,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Regular',
            ),
            controller: quantityController,
            decoration: const InputDecoration(
              helperText: "200 ml",
              hintText: 'Ilość',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Regular',
            ),
            controller: priceController,
            decoration: const InputDecoration(
              helperText: "10 PLN",
              hintText: 'Cena',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }
}
