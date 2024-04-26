import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:purena_lemo/screens/video_screen.dart';
import 'package:purena_lemo/screens/widgets/my_button.dart';
import 'package:purena_lemo/screens/widgets/video_widget.dart';
import 'package:video_player/video_player.dart';

import '../constants/enums.dart';
import '../constants/maps.dart';
import '../models/logo_state.dart';
import '../services/translation_service.dart';
import '../utils/svg_utils.dart';
import 'dialogs/color_picker_dialog.dart';
import 'dialogs/language_selection_dialog.dart';
import 'dialogs/presentation_type_dialog.dart';
import 'dialogs/product_type_dialog.dart';
import 'dialogs/select_logo_dialog.dart';
import 'dialogs/settings_dialog.dart';

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
            _buildLogoSection(context),
            Expanded(
              child: Row(
                children: [
                  _buildSettingsTable(context),
                  _buildVideoWidgetContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildSettingsTable(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                  onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LanguageSelectionDialog(
                            currentLanguage: currentLanguage,
                            onLanguageSelected: (selectedLanguage) {
                              setState(() {
                                currentLanguage = selectedLanguage;
                                updateProductNames();
                              });
                            },
                          );
                        },
                      ),
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
                onPressed: () async {
                  await showDialog<ProductType>(
                    context: context,
                    builder: (BuildContext context) {
                      return ProductTypeDialog(
                        currentLanguage: currentLanguage,
                        initialProductType: _productType,
                        onProductTypeSelected: (ProductType selectedProduct) {
                          if (selectedProduct != _productType) {
                            setState(() {
                              _productType = selectedProduct;
                              _controller.dispose();
                              _controller = VideoPlayerController.asset(
                                  productTypeMovies[_productType]!)
                                ..initialize().then((_) {
                                  setState(() {
                                    _controller.setLooping(true);
                                    _controller.play();
                                  });
                                });
                            });
                          }
                        },
                      );
                    },
                  );
                },
                text: productTypeNames[_productType] ?? 'Undefined',
              ),
              SizedBox(width: _space),
            ],
          ),
          TableRow(
            children: [
              Text(TranslationService.getTranslation(
                  currentLanguage, "choose_presentation_type")),
              SizedBox(width: _space),
              MyButton(
                onPressed: () async {
                  await showDialog<PresentationType>(
                    context: context,
                    builder: (BuildContext context) {
                      return PresentationTypeDialog(
                        currentLanguage: currentLanguage,
                        initialPresentationType: _presentationType,
                        onPresentationTypeSelected:
                            (PresentationType selectedType) {
                          setState(() {
                            _presentationType = selectedType;
                          });
                        },
                      );
                    },
                  );
                },
                text: presentationTypeNames[_presentationType] ?? 'Undefined',
              ),
              SizedBox(width: _space),
            ],
          ),
          TableRow(
            children: [
              Text(TranslationService.getTranslation(
                  currentLanguage, "set_parameters")),
              SizedBox(width: _space),
              MyButton(
                  onPressed: () => {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return SettingsDialog(
                              portionStates: portionStates,
                              quantityControllers: [
                                _quantityController1,
                                _quantityController2,
                                _quantityController3,
                              ],
                              priceControllers: [
                                _priceController1,
                                _priceController2,
                                _priceController3,
                              ],
                              onSave: (updatedPortionStates) {
                                setState(() {
                                  portionStates = updatedPortionStates;
                                });
                              },
                              currentLanguage: currentLanguage,
                            );
                          },
                        )
                      },
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
                onPressed: () async {
                  await showDialog<Color>(
                    context: context,
                    builder: (BuildContext context) {
                      return ColorPickerDialog(
                        initialColor: currentColor,
                        onColorSelected: (Color color) {
                          setState(() {
                            currentColor = color;
                          });
                        },
                      );
                    },
                  );
                },
                text: colorToRgbString(currentColor),
                buttonColor: currentColor,
              ),
              SizedBox(width: _space),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildLogoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSvgPicture(Provider.of<LogoState>(context).logoUrl),
          MyButton(
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const SelectLogoDialog();
                },
              ),
            },
            text: "Wybierz logo...",
          )
        ],
      ),
    );
  }

  Expanded _buildVideoWidgetContainer() {
    return Expanded(
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
                presentationType: _presentationType)));
  }
}
