import '../constants/enums.dart';

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
  };

  static String getTranslation(String language, String key) {
    return _translations[language]?[key] ?? key;
  }

  static String getProductTranslation(
      String language, ProductType productType) {
    return _productTranslations[language]?[productType] ?? 'Unknown Product';
  }
}
