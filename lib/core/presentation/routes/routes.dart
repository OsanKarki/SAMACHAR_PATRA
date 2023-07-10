import 'package:get/get.dart';
import 'package:newsapp_restapi/features/category/bindings/category_news_bindings.dart';
import 'package:newsapp_restapi/features/category/view/catergory_news_page.dart';
import '../../../features/home_page/bindings/news_bindings.dart';
import '../../../features/home_page/view/home_page.dart';
import '../../../features/webview/view/web_view_page.dart';

class AppRoutes {
  static String homePage = "/homePage";
  static String webViewPage = "/webViewPage";
  static String categoryNewsPage = "/categoryNewsPage";

  static final routes = [
    GetPage(
        name: homePage, page: () => const HomePage(), binding: NewsBindings()),
    GetPage(name: webViewPage, page: () => const WebViewPage()),
    GetPage(
        name: categoryNewsPage,
        page: () => const CategoryNewsPage(),
        binding: CategoryNewsBindings()),
  ];
}
