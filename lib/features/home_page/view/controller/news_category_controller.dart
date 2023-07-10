import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:newsapp_restapi/features/home_page/model/category_model.dart';

import '../../repository/news_info_repository.dart';

class NewsCategoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNewsCategory();
  }

  Either<NetworkException, List<NewsCategoryModel>>? result;

  Future<void> getNewsCategory() async {
    result = await NewsInfoRepository().getNewsCategoryName();
    update();
  }
}
