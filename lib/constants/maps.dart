import '../services/translation_service.dart';
import 'enums.dart';

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

Map<PresentationType, String> presentationTypeNames = {
  PresentationType.type1: '1',
  PresentationType.type2: '2',
  PresentationType.type3: '3',
};
