import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp_restapi/core/presentation/routes/routes.dart';
import 'package:newsapp_restapi/features/home_page/view/controller/news_category_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/widgets/error_view.dart';
import 'controller/get_news_info_controller.dart';
import 'controller/get_top_news_info_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1C1E21),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Samchar Patra",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.newspaper,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.search_outlined,
                                color: Colors.white38,
                              ),
                              Text(
                                "Search",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white60),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.filter_list_sharp,
                            color: Colors.white38,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: GetBuilder<NewsCategoryController>(
                    builder: (controller) {
                      final result = controller.result;
                      if (result != null) {
                        return result.fold(
                          (l) => ErrorView(l.value),
                          (categoryList) {

                           final  newsCategoryList = categoryList
                                .map((category) => category.category)
                                .toSet()
                                .toList();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: newsCategoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final category = newsCategoryList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.categoryNewsPage,
                                            arguments: category);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.cyanAccent)),
                                          child: Text(
                                            "$category",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          )),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 40,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Headlines",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Text("See all")
                        ],
                      ),
                      Expanded(
                        child: GetBuilder<GetTopNewsController>(
                          builder: (controller) {
                            final result = controller.result;
                            if (result != null) {
                              return result.fold((l) => ErrorView(l.value),
                                  (topNewsList) {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: topNewsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.webViewPage,
                                            arguments: topNewsList[index].url);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              height: 160,
                                              imageUrl:
                                                  '${topNewsList[index].urlToImage}',
                                              placeholder: (context, url) =>
                                                  Shimmer(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Colors.grey.shade200,
                                                    Colors.grey.shade400,
                                                    Colors.grey.shade200
                                                  ],
                                                  stops: const [0.0, 0.5, 1.0],
                                                ),
                                                child: Container(
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/png/noImage.png"),
                                            ),
                                            Text(
                                                "${topNewsList[index].source?.name}"),
                                            SizedBox(
                                              width: 220,
                                              child: Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  "${topNewsList[index].title}"),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                );
                              });
                            } else {
                              return LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white,
                                size: 40,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest News",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text("See all"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GetBuilder<GetNewsController>(
                    builder: (controller) {
                      final result = controller.result;
                      if (result != null) {
                        return result.fold((l) => ErrorView(l.value), (_) {
                          final newsList = controller.newsModelList;
                          return SmartRefresher(
                            enablePullUp: true,
                            enablePullDown: false,
                            controller: controller.refreshController,
                            onLoading: controller.lazyLoad,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: newsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final news = newsList[index];
                                  String formatDate(String timestamp) {
                                    DateTime dateTime =
                                        DateTime.parse(timestamp);
                                    DateFormat formatter =
                                        DateFormat('d MMMM, yyyy');
                                    return formatter.format(dateTime);
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.webViewPage,
                                          arguments: newsList[index].url);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: CachedNetworkImage(
                                                imageUrl: "${news.urlToImage}",
                                                placeholder: (context, url) =>
                                                    Shimmer(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Colors.grey.shade200,
                                                      Colors.grey.shade400,
                                                      Colors.grey.shade200
                                                    ],
                                                    stops: const [
                                                      0.0,
                                                      0.5,
                                                      1.0
                                                    ],
                                                  ),
                                                  child: Container(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  "assets/png/noImage.png",
                                                  height: 80,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      "${news.title}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    )),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        " ${news.source?.name}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      Text(
                                                        " ${formatDate("${news.publishedAt}")}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 10),
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
                                }),
                          );
                        });
                      } else {
                        return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 40,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
