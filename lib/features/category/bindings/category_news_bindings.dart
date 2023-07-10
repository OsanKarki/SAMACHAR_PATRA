import 'package:get/get.dart';
import 'package:newsapp_restapi/features/category/view/controller/get_category_news_info.dart';

class CategoryNewsBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(GetCategoryNewsInfo());
  }

}