import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../model/news_model.dart';
import '../../repository/news_info_repository.dart';

class GetTopNewsController extends GetxController{
  @override
  void onInit(){
    super.onInit();
    getTopNewsInfo();
  }

  Either<NetworkException , List<NewsModel>>?result;

  Future<void>getTopNewsInfo()async{
    result = await NewsInfoRepository().getTopNewsInfo();
    update();
  }
}