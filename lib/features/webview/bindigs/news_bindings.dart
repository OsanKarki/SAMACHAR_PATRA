import 'package:get/get.dart';
import 'package:newsapp_restapi/features/news/view/controller/news_detail_controller.dart';

class NewsDetailBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(NewsDetailController());
  }

}