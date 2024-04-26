import 'package:flutter/material.dart';
import 'package:purena_lemo/constants/enums.dart';
import 'package:purena_lemo/constants/maps.dart';
import 'package:purena_lemo/services/translation_service.dart';

class ProductTypeDialog extends StatelessWidget {
  final String currentLanguage;
  final ProductType initialProductType;
  final Function(ProductType) onProductTypeSelected;

  const ProductTypeDialog({
    super.key,
    required this.currentLanguage,
    required this.initialProductType,
    required this.onProductTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
          TranslationService.getTranslation(currentLanguage, "choose_product")),
      children: ProductType.values.map((product) {
        return SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            onProductTypeSelected(product);
          },
          child: Text(productTypeNames[product] ?? 'Undefined'),
        );
      }).toList(),
    );
  }
}
