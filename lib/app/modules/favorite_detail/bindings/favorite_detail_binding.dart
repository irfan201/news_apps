import 'package:get/get.dart';

import '../controllers/favorite_detail_controller.dart';

class FavoriteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteDetailController>(
      () => FavoriteDetailController(),
    );
  }
}
