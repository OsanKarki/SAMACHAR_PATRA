import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp_restapi/features/category/view/controller/get_category_news_info.dart';
import '../../../core/presentation/routes/routes.dart';
import '../../../core/widgets/error_view.dart';

class CategoryNewsPage extends StatefulWidget {
  const CategoryNewsPage({Key? key}) : super(key: key);

  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  @override
  void initState() {
    super.initState();

    Get.find<GetCategoryNewsInfo>().getCategoryNewsInfo(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.arguments.toString().capitalize}"),
      ),
      body: GetBuilder<GetCategoryNewsInfo>(
        builder: (controller) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value), (categoryNewsInfo) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryNewsInfo.length,
                  itemBuilder: (BuildContext context, int index) {
                    final catNews = categoryNewsInfo[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.webViewPage,
                            arguments: catNews.url);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Image.asset("assets/png/noImage.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            "${catNews.name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text("${catNews.country}")
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            " ${catNews.description}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
          } else {
            return LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 40,
            );
          }
        },
      ),
    );
  }
}
