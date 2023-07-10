import 'package:get/get.dart';
import 'package:newsapp_restapi/features/home_page/view/controller/news_category_controller.dart';
import '../view/controller/get_news_info_controller.dart';
import '../view/controller/get_top_news_info_controller.dart';

class NewsBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(GetNewsController());
   Get.put(GetTopNewsController());
   Get.put(NewsCategoryController());
  }

}