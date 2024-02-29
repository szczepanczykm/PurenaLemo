import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class LogoState with ChangeNotifier {
  String _logoUrl = 'assets/images/logo_purena.svg';

  String get logoUrl => _logoUrl;

  set logoUrl(String newValue) {
    _logoUrl = newValue;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LogoState(),
      child: const MyApp(),
    ),
  );
}

class TranslationService {
  static final Map<String, Map<String, String>> _translations = {
    'Polski': {
      'choose_language': 'Wybierz język',
      'choose_product': 'Wybierz produkt',
      'choose_presentation_type': 'Wybierz typ prezentacji',
      'set_parameters': 'Ustaw parametry',
      'text_color': 'Kolor tekstu',
      'lemonade_flavor': 'Lemoniada cytryna - pomarańcza',
    },
    'English': {
      'choose_language': 'Choose language',
      'choose_product': 'Choose product',
      'choose_presentation_type': 'Choose presentation type',
      'set_parameters': 'Set parameters',
      'text_color': 'Text color',
      'lemonade_flavor': 'Lemonade lemon - orange',
    },
    'Italiano': {
      'choose_language': 'Scegli la lingua',
      'choose_product': 'Scegli il prodotto',
      'choose_presentation_type': 'Scegli il tipo di presentazione',
      'set_parameters': 'Imposta i parametri',
      'text_color': 'Colore del testo',
      'lemonade_flavor': 'Limonata limone - arancia',
    },
    'Czech': {
      'choose_language': 'Vyberte jazyk',
      'choose_product': 'Vyberte produkt',
      'choose_presentation_type': 'Vyberte typ prezentace',
      'set_parameters': 'Nastavit parametry',
      'text_color': 'Barva textu',
      'lemonade_flavor': 'Limonáda citron - pomeranč',
    },
    'Dutch': {
      'choose_language': 'Kies taal',
      'choose_product': 'Kies product',
      'choose_presentation_type': 'Kies presentatietype',
      'set_parameters': 'Instellingen parameters',
      'text_color': 'Tekstkleur',
      'lemonade_flavor': 'Limonade citroen - sinaasappel',
    },
    // Add more languages here...
  };
  static final Map<String, Map<ProductType, String>> _productTranslations = {
    'Polski': {
      ProductType.product1: 'Lemoniada \ncytryna - pomarańcza',
      ProductType.product2: 'Lemoniada \ncytryna – limetka',
      ProductType.product3: 'Lemoniada \ncytryna – rabarbar',
      ProductType.product4: 'Lemoniada \ncytryna – mango',
      ProductType.product5: 'Lemoniada \ncytryna – malina',
    },
    'English': {
      ProductType.product1: 'Lemon - orange\nlemonade ',
      ProductType.product2: 'Lemon – lime\nlemonade ',
      ProductType.product3: 'Lemon – rhubarb\nlemonade ',
      ProductType.product4: 'Lemon – mango\nlemonade ',
      ProductType.product5: 'Lemon – raspberry\nlemonade ',
    },
    'Italiano': {
      ProductType.product1: 'Limonata \nlimone - arancia',
      ProductType.product2: 'Limonata \nlimone – lime',
      ProductType.product3: 'Limonata \nlimone – rabarbaro',
      ProductType.product4: 'Limonata \nlimone – mango',
      ProductType.product5: 'Limonata \nlimone – lampone',
    },
    'Czech': {
      ProductType.product1: 'Limonáda \ncitron - pomeranč',
      ProductType.product2: 'Limonáda \ncitron – limetka',
      ProductType.product3: 'Limonáda \ncitron – rebarbora',
      ProductType.product4: 'Limonáda \ncitron – mango',
      ProductType.product5: 'Limonáda \ncitron – malina',
    },
    'Dutch': {
      ProductType.product1: 'Limonade \ncitroen - sinaasappel',
      ProductType.product2: 'Limonade \ncitroen – limoen',
      ProductType.product3: 'Limonade \ncitroen – rabarber',
      ProductType.product4: 'Limonade \ncitroen – mango',
      ProductType.product5: 'Limonade \ncitroen – framboos',
    },
    // Additional languages...
  };

  static String getTranslation(String language, String key) {
    return _translations[language]?[key] ?? key;
  }

  static String getProductTranslation(
      String language, ProductType productType) {
    return _productTranslations[language]?[productType] ?? 'Unknown Product';
  }
}

Widget getSvgPicture(String logoPath) {
  // if logoPath is an asset and logoPath ends with .svg
  if (logoPath.startsWith('assets/') && logoPath.endsWith(".svg")) {
    return SvgPicture.asset(
      logoPath,
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
  // if logoPath is a network URL and logoPath ends with .svg
  else if (logoPath.startsWith('http') && logoPath.endsWith(".svg")) {
    return SvgPicture.network(
      logoPath,
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
  // if logoPath is a device path and logoPath ends with .svg
  else if (logoPath.startsWith('/') && logoPath.endsWith(".svg")) {
    return SvgPicture.file(
      File(logoPath),
      semanticsLabel: 'Purena Logo',
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
  // if logoPath is an asset and logoPath ends with .png
  else if (logoPath.startsWith('assets/') && logoPath.endsWith(".png")) {
    return Image.asset(
      logoPath,
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
  // if logoPath is a network URL and logoPath ends with .png
  else if (logoPath.startsWith('http') && logoPath.endsWith(".png")) {
    return Image.network(
      logoPath,
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }
  // if logoPath is a device path and logoPath ends with .png
  else if (logoPath.startsWith('/') && logoPath.endsWith(".png")) {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Purena',
      ),
      home: const MyHomeScreen(),
    );
  }
}

enum PresentationType {
  type1,
  type2,
  type3,
}

Map<PresentationType, String> presentationTypeNames = {
  PresentationType.type1: '1',
  PresentationType.type2: '2',
  PresentationType.type3: '3',
};

enum ProductType {
  product1,
  product2,
  product3,
  product4,
  product5,
}

Map<ProductType, String> productTypeNames = {
  ProductType.product1:
      TranslationService.getProductTranslation('Polski', ProductType.product1),
  ProductType.product2:
      TranslationService.getProductTranslation('Polski', ProductType.product2),
  ProductType.product3:
      TranslationService.getProductTranslation('Polski', ProductType.product3),
  ProductType.product4:
      TranslationService.getProductTranslation('Polski', ProductType.product4),
  ProductType.product5:
      TranslationService.getProductTranslation('Polski', ProductType.product5),
};

Map<ProductType, String> productTypeMovies = {
  ProductType.product1: 'assets/videos/pomarancza.mp4',
  ProductType.product2: 'assets/videos/limonka.mp4',
  ProductType.product3: 'assets/videos/rabarbar.mp4',
  ProductType.product4: 'assets/videos/mango.mp4',
  ProductType.product5: 'assets/videos/malina.mp4',
};

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Color pickerColor = Colors.green;
  Color currentColor = Colors.green;
  String currentLanguage = 'Polski';

  List<Map<String, dynamic>> portionStates = [
    {
      'isChecked': true,
      'quantity': '200 ml',
      'price': '7 PLN',
      'assetPath': 'assets/images/size_s.svg',
    },
    {
      'isChecked': true,
      'quantity': '300 ml',
      'price': '9 PLN',
      'assetPath': 'assets/images/size_m.svg',
    },
    {
      'isChecked': true,
      'quantity': '500 ml',
      'price': '13 PLN',
      'assetPath': 'assets/images/size_l.svg',
    },
  ];

  bool isChecked1 = true;
  bool isChecked2 = true;
  bool isChecked3 = true;

  final TextEditingController _quantityController1 =
      TextEditingController(text: "200 ml");
  final TextEditingController _priceController1 =
      TextEditingController(text: "10 PLN");
  final TextEditingController _quantityController2 =
      TextEditingController(text: "300 ml");
  final TextEditingController _priceController2 =
      TextEditingController(text: "15 PLN");
  final TextEditingController _quantityController3 =
      TextEditingController(text: "450 ml");
  final TextEditingController _priceController3 =
      TextEditingController(text: "20 PLN");

  late VideoPlayerController _controller;
  late PresentationType _presentationType;
  late ProductType _productType;
  late double _space;

  @override
  void initState() {
    super.initState();
    _presentationType = PresentationType.type1;
    _productType = ProductType.product1;
    _space = 14;

    _controller =
        VideoPlayerController.asset(productTypeMovies[ProductType.product1]!)
          ..initialize().then((_) {
            setState(() {
              _controller.setLooping(true);
              _controller.play();
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateProductNames() {
    productTypeNames = {
      ProductType.product1: TranslationService.getProductTranslation(
          currentLanguage, ProductType.product1),
      ProductType.product2: TranslationService.getProductTranslation(
          currentLanguage, ProductType.product2),
      ProductType.product3: TranslationService.getProductTranslation(
          currentLanguage, ProductType.product3),
      ProductType.product4: TranslationService.getProductTranslation(
          currentLanguage, ProductType.product4),
      ProductType.product5: TranslationService.getProductTranslation(
          currentLanguage, ProductType.product5),
    };
  }

  void _goToVideoScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenVideoScreen(
          controller: _controller,
          textColor: currentColor,
          productTitleText: productTypeNames[_productType]!,
          selectedPortions:
              portionStates.where((portion) => portion['isChecked']).toList(),
          presentationType: _presentationType,
        ),
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  String colorToRgbString(Color color) {
    return 'RGB(${color.red}, ${color.green}, ${color.blue})';
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wybierz kolor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                setState(() {
                  pickerColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  currentColor = pickerColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSettingsDialog(BuildContext context) async {
    bool localIsChecked1 = isChecked1;
    bool localIsChecked2 = isChecked2;
    bool localIsChecked3 = isChecked3;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(TranslationService.getTranslation(
                  currentLanguage, "set_parameters")),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    _settingsRow(context, 0, localIsChecked1, setDialogState,
                        (bool? value) {
                      localIsChecked1 = value ?? localIsChecked1;
                    }),
                    _settingsRow(context, 1, localIsChecked2, setDialogState,
                        (bool? value) {
                      localIsChecked2 = value ?? localIsChecked2;
                    }),
                    _settingsRow(context, 2, localIsChecked3, setDialogState,
                        (bool? value) {
                      localIsChecked3 = value ?? localIsChecked3;
                    }),
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
                    setState(() {
                      portionStates[0]['quantity'] =
                          _quantityController1.text.isNotEmpty
                              ? _quantityController1.text
                              : portionStates[0]['quantity'];
                      portionStates[0]['price'] =
                          _priceController1.text.isNotEmpty
                              ? _priceController1.text
                              : portionStates[0]['price'];
                      portionStates[1]['quantity'] =
                          _quantityController2.text.isNotEmpty
                              ? _quantityController2.text
                              : portionStates[1]['quantity'];
                      portionStates[1]['price'] =
                          _priceController2.text.isNotEmpty
                              ? _priceController2.text
                              : portionStates[1]['price'];
                      portionStates[2]['quantity'] =
                          _quantityController3.text.isNotEmpty
                              ? _quantityController3.text
                              : portionStates[2]['quantity'];
                      portionStates[2]['price'] =
                          _priceController3.text.isNotEmpty
                              ? _priceController3.text
                              : portionStates[2]['price'];

                      isChecked1 = localIsChecked1;
                      isChecked2 = localIsChecked2;
                      isChecked3 = localIsChecked3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _settingsRow(BuildContext context, int rowNumber, bool isChecked,
      StateSetter setDialogState, Function(bool?) onCheckedChanged) {
    TextEditingController quantityController = rowNumber == 0
        ? _quantityController1
        : rowNumber == 1
            ? _quantityController2
            : _quantityController3;
    TextEditingController priceController = rowNumber == 0
        ? _priceController1
        : rowNumber == 1
            ? _priceController2
            : _priceController3;
    String portionTitle = "${rowNumber + 1}.";

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(portionTitle, textAlign: TextAlign.right),
        ),
        Checkbox(
          value: portionStates[rowNumber]['isChecked'],
          onChanged: (bool? value) {
            setDialogState(() {
              portionStates[rowNumber]['isChecked'] = value!;
            });
          },
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

  void _showPresentationTypeDialog() async {
    PresentationType? selectedType = _presentationType;

    await showDialog<PresentationType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(TranslationService.getTranslation(
              currentLanguage, "choose_presentation_type")),
          children: PresentationType.values.map((type) {
            return SimpleDialogOption(
              onPressed: () {
                selectedType = type;
                Navigator.pop(context);
              },
              child: Text(presentationTypeNames[type] ?? 'Undefined'),
            );
          }).toList(),
        );
      },
    );

    if (selectedType != null) {
      setState(() {
        _presentationType = selectedType!;
      });
    }
  }

  void _showProductTypeDialog() async {
    ProductType? selectedProduct = _productType;

    await showDialog<ProductType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(TranslationService.getTranslation(
              currentLanguage, "choose_product")),
          children: ProductType.values.map((product) {
            return SimpleDialogOption(
              onPressed: () {
                selectedProduct = product;
                Navigator.pop(context);
              },
              child: Text(productTypeNames[product] ?? 'Undefined'),
            );
          }).toList(),
        );
      },
    );

    if (selectedProduct != null && selectedProduct != _productType) {
      setState(() {
        _productType = selectedProduct!;
        _controller.dispose();
        _controller =
            VideoPlayerController.asset(productTypeMovies[_productType]!)
              ..initialize().then((_) {
                setState(() {
                  _controller.setLooping(true);
                  _controller.play();
                });
              });
      });
    }
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(TranslationService.getTranslation(
              currentLanguage, "choose_language")),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Polski');
                setState(() {
                  currentLanguage = 'Polski';
                  updateProductNames();
                });
              },
              child: const Text('Polski'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'English');
                setState(() {
                  currentLanguage = 'English';
                  updateProductNames();
                });
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Italiano');
                setState(() {
                  currentLanguage = 'Italiano';
                  updateProductNames();
                });
              },
              child: const Text('Italiano'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Czech');
                setState(() {
                  currentLanguage = 'Czech';
                  updateProductNames();
                });
              },
              child: const Text('Czech'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Dutch');
                setState(() {
                  currentLanguage = 'Dutch';
                  updateProductNames();
                });
              },
              child: const Text('Dutch'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _goToVideoScreen(context);
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSvgPicture(Provider.of<LogoState>(context).logoUrl),
                  MyButton(
                      onPressed: () => {
                            _showSelectLogoDialog(context),
                          },
                      text: "Wybierz logo...")
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  SingleChildScrollView(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            Text(
                                '${TranslationService.getTranslation(currentLanguage, "choose_language")}: '),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () =>
                                    _showLanguageSelectionDialog(context),
                                text: currentLanguage),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(TranslationService.getTranslation(
                                currentLanguage, "choose_product")),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () => {_showProductTypeDialog()},
                                text: productTypeNames[_productType]!),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(TranslationService.getTranslation(
                                currentLanguage, "choose_presentation_type")),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () =>
                                    {_showPresentationTypeDialog()},
                                text:
                                    presentationTypeNames[_presentationType]!),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(TranslationService.getTranslation(
                                currentLanguage, "set_parameters")),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () => {_showSettingsDialog(context)},
                                text: TranslationService.getTranslation(
                                    currentLanguage, "set_parameters")),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(TranslationService.getTranslation(
                                currentLanguage, "text_color")),
                            SizedBox(width: _space),
                            MyButton(
                              onPressed: () => {_showColorPickerDialog()},
                              text: colorToRgbString(currentColor),
                              buttonColor: currentColor,
                            ),
                            SizedBox(width: _space),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: Colors.white),
                          ),
                          child: VideoWidget(
                              controller: _controller,
                              textColor: currentColor,
                              text: productTypeNames[_productType]!,
                              selectedPortions: portionStates
                                  .where((portion) => portion['isChecked'])
                                  .toList(),
                              presentationType: _presentationType))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSelectLogoDialog(BuildContext context) {
  TextEditingController logoUrlController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Logo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Enter the URL of your logo.'),
            TextField(
              controller: logoUrlController,
              decoration: const InputDecoration(hintText: "Logo URL"),
            ),
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['svg', 'png'],
                  );
                  if (result != null && result.files.single.path != null) {
                    String filePath = result.files.single.path!;
                    logoUrlController.text = filePath;
                  }
                },
                child: const Text('Select Logo...')),
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
                  logoUrlController.text;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class FullScreenVideoScreen extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final String productTitleText;
  final List<Map<String, dynamic>> selectedPortions;
  final PresentationType presentationType;

  const FullScreenVideoScreen({
    super.key,
    required this.controller,
    this.textColor = Colors.white,
    this.productTitleText = '',
    required this.selectedPortions,
    required this.presentationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: SystemUiOverlay.values);
          }
        },
        child: VideoWidget(
          controller: controller,
          textColor: textColor,
          text: productTitleText,
          selectedPortions: selectedPortions,
          presentationType: presentationType,
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget(
      {super.key,
      required this.controller,
      required this.textColor,
      required this.text,
      required this.selectedPortions,
      required this.presentationType});

  final VideoPlayerController controller;
  final Color textColor;
  final String text;
  final List<Map<String, dynamic>> selectedPortions;
  final PresentationType presentationType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        controller.value.isInitialized
            ? VideoPlayer(controller)
            : const CircularProgressIndicator(),
        ProductPricesOverlayWidget(
          controller: controller,
          textColor: textColor,
          selectedPortions: selectedPortions,
          presentationType: presentationType,
        ),
        ProductTitleOverlay(
          text: text,
          textColor: textColor,
          presentationType: presentationType,
        ),
      ],
    );
  }
}

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
          alignment: Alignment.bottomCenter, // Keep this to align horizontally
          child: Padding(
            // Adjust the padding to lift the text up above the white row
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
          alignment: Alignment.bottomCenter, // Keep this to align horizontally
          child: Padding(
            // Adjust the padding to lift the text up above the white row
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

class ProductPricesOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final List<Map<String, dynamic>> selectedPortions;
  final PresentationType presentationType;

  const ProductPricesOverlayWidget(
      {super.key,
      required this.controller,
      required this.textColor,
      required this.selectedPortions,
      required this.presentationType});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (presentationType == PresentationType.type1) {
        double iconSize = constraints.maxHeight / 7;
        double fontSize = constraints.maxHeight / 23;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(
              portion['assetPath']!,
              portion['quantity']!,
              portion['price']!,
              iconSize,
              fontSize,
              textColor);
        }).toList();

        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getSvgPicture(Provider.of<LogoState>(context).logoUrl),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      } else if (presentationType == PresentationType.type2) {
        double imageSize = constraints.maxHeight / 9;
        double iconSize = constraints.maxHeight / 10;
        double fontSize = constraints.maxHeight / 28;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(
              portion['assetPath']!,
              portion['quantity']!,
              portion['price']!,
              iconSize,
              fontSize,
              textColor);
        }).toList();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: imageSize / 3),
                child: getSvgPicture(Provider.of<LogoState>(context).logoUrl),
              ),
              Container(
                height: imageSize * 2,
                // This is the height of the area for the product sizes.
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      } else {
        double imageSize = constraints.maxHeight / 5;
        double iconSize = constraints.maxHeight / 4;
        double fontSize = constraints.maxHeight / 21;

        List<Widget> productSizeColumns = selectedPortions.map((portion) {
          return buildProductSizeColumn(
              portion['assetPath']!,
              portion['quantity']!,
              portion['price']!,
              iconSize,
              fontSize,
              textColor);
        }).toList();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: imageSize / 3),
                child: getSvgPicture(Provider.of<LogoState>(context).logoUrl),
              ),
              Container(
                height: imageSize * 2,
                // This is the height of the area for the product sizes.
                color: Colors.white.withOpacity(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Column buildProductSizeColumn(String assetPath, String sizeText,
      String priceText, double iconSize, double fontSize, Color currentColor) {
    TextStyle adjustedTextStyle = TextStyle(
      color: currentColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto Mono',
      // other style properties
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // Center column items vertically
      children: [
        SvgPicture.asset(assetPath, height: iconSize),
        AutoSizeText(
          sizeText,
          style: adjustedTextStyle,
          maxLines: 1,
        ),
        AutoSizeText(
          priceText,
          style: adjustedTextStyle,
          maxLines: 1,
        ),
      ],
    );
  }
}
