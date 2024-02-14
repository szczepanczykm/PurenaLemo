import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

/* ****************************************************************************
1.	Wybierz język / choose language ( ok 6 języków)
2.	Wybierz logo ( domyślne PURENA, personalizowane wgraj z lokalizacji …., wymogi …)
3.	Wybierz produkt ( ok 7 produktów możliwych do wyboru)
4.	Wybierz typ apletu ( i tu będą 3 sposoby prezentacji cenówek, podam)
5.	Wybierz 2 z 3 formatów porcji (200 ml, XL  300 ml i  XXL 450 ml)
6.	Przypisz ceny
7.	Graj / Play
******************************************************************************/

void main() {
  runApp(const MyApp());
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
  PresentationType.type1: 'Typ 1',
  PresentationType.type2: 'Typ 2',
  PresentationType.type3: 'Typ 3',
};

enum ProductType {
  product1,
  product2,
  product3,
  product4,
  product5,
}

Map<ProductType, String> productTypeNames = {
  ProductType.product1: 'Lemoniada \ncytryna - pomarańcza',
  ProductType.product2: 'Lemoniada \ncytryna – limetka',
  ProductType.product3: 'Lemoniada \ncytryna – rabarbar',
  ProductType.product4: 'Lemoniada \ncytryna – mango',
  ProductType.product5: 'Lemoniada \ncytryna – malina',
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

  void _goToVideoScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenVideoScreen(
          controller: _controller,
          textColor: currentColor,
          productTitleText: productTypeNames[_productType]!,
          selectedPortions:
              portionStates.where((portion) => portion['isChecked']).toList(),
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
              title: const Text('Ustaw parametry'),
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
          title: const Text('Wybierz typ prezentacji'),
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
          title: const Text('Wybierz produkt'),
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
                  SvgPicture.asset(
                    'assets/images/logo_purena.svg',
                    semanticsLabel: 'Purena Logo',
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  MyButton(onPressed: () => {}, text: "Wybierz logo...")
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
                            const Text('Wybierz język: '),
                            SizedBox(width: _space),
                            MyButton(onPressed: () => {}, text: "Polski"),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wybierz produkt: '),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () => {_showProductTypeDialog()},
                                text: productTypeNames[_productType]!),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wybierz typ \nprezentacji: '),
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
                            const Text('Ustaw parametry: '),
                            SizedBox(width: _space),
                            MyButton(
                                onPressed: () => {_showSettingsDialog(context)},
                                text: "Ustaw parametry"),
                            SizedBox(width: _space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Kolor tekstu: '),
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
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenVideoScreen extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final String productTitleText;
  final List<Map<String, dynamic>> selectedPortions;

  const FullScreenVideoScreen({
    super.key,
    required this.controller,
    this.textColor = Colors.white,
    this.productTitleText = '',
    required this.selectedPortions,
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
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.controller,
    required this.textColor,
    required this.text,
    required this.selectedPortions,
  });

  final VideoPlayerController controller;
  final Color textColor;
  final String text;
  final List<Map<String, dynamic>> selectedPortions;

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
        ),
        ProductTitleOverlay(
          text: text,
          textColor: textColor,
        ),
      ],
    );
  }
}

class ProductTitleOverlay extends StatelessWidget {
  const ProductTitleOverlay({
    super.key,
    required this.text,
    this.textColor = Colors.white,
  });

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
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
  }
}

class ProductPricesOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final Color textColor;
  final List<Map<String, dynamic>> selectedPortions;

  const ProductPricesOverlayWidget({
    super.key,
    required this.controller,
    required this.textColor,
    required this.selectedPortions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxHeight / 6;
        double iconSize = constraints.maxHeight / 10;
        double fontSize = constraints.maxHeight / 30;

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
              Image.asset(
                'assets/images/logo_purena.png',
                height: imageSize,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: productSizeColumns,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Column buildProductSizeColumn(String assetPath, String sizeText,
      String priceText, double iconSize, double fontSize, Color currentColor) {
    TextStyle adjustedTextStyle = TextStyle(
      color: currentColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.lato().fontFamily,
      shadows: const [
        Shadow(
          blurRadius: 5.0,
          color: Colors.greenAccent,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );

    return Column(
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
