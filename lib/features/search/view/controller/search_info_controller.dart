import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:newsapp_restapi/features/home_page/model/news_model.dart';
import 'package:newsapp_restapi/features/home_page/repository/news_info_repository.dart';
import 'package:newsapp_restapi/features/search/repository/search_repository.dart';

class SearchInfoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Either<NetworkException, List<NewsModel>>? result;

  Future<void> getSearchInfo(String searchQuery) async {
    result = await SearchRepository().getSearchItem(searchQuery);
    update();
  }
}
