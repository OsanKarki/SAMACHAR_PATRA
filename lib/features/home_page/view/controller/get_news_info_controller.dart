import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/news_model.dart';
import '../../repository/news_info_repository.dart';

class GetNewsController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    getNewsInfo();
  }

  Either<NetworkException, List<NewsModel>>? result;

  int page = 1;

  List<NewsModel> newsModelList = [];

  Future<void> getNewsInfo() async {
    result = await NewsInfoRepository().getNewsInfo(page);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@222");

    result?.fold((l) => null, (r) {
      newsModelList.addAll(r);
    });

    print(newsModelList.length);

    refreshController.loadComplete();

    update();
  }

  lazyLoad() {
    page++;
    getNewsInfo();
  }
}
