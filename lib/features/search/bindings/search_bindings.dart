import 'package:get/get.dart';
import 'package:newsapp_restapi/features/search/view/controller/search_info_controller.dart';

class SearchBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(SearchInfoController());
  }

}