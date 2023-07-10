import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:newsapp_restapi/features/category/repository/category_news_repository.dart';
import 'package:newsapp_restapi/features/home_page/model/category_model.dart';

import '../../../home_page/repository/news_info_repository.dart';

class GetCategoryNewsInfo extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Either<NetworkException, List<NewsCategoryModel>>? result;

  Future<void> getCategoryNewsInfo(String category) async {
    result = await NewsCategoryRepository().getNewsCategoryInfo(category);
    update();
  }
}
