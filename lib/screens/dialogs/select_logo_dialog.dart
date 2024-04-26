import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purena_lemo/models/logo_state.dart';

class SelectLogoDialog extends StatefulWidget {
  const SelectLogoDialog({super.key});

  @override
  SelectLogoDialogState createState() => SelectLogoDialogState();
}

class SelectLogoDialogState extends State<SelectLogoDialog> {
  final TextEditingController _logoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Logo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Enter the URL of your logo.'),
          TextField(
            controller: _logoUrlController,
            decoration: const InputDecoration(hintText: "Logo URL"),
          ),
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['svg', 'png'],
              );
              if (result != null && result.files.single.path != null) {
                String filePath = result.files.single.path!;
                _logoUrlController.text = filePath;
              }
            },
            child: const Text('Select Logo...'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Provider.of<LogoState>(context, listen: false).logoUrl =
                _logoUrlController.text;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
