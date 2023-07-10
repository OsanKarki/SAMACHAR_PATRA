import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../home_page/model/news_model.dart';
import '../../../home_page/repository/news_info_repository.dart';
import '../../repository/get_news_details_repository.dart';

class NewsDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Either<NetworkException, NewsModel>? result;

  Future<void> getNewsInfo(String id) async {
    result = await NewsDetailRepository().getNewsDetail(id);
    update();
  }
}
