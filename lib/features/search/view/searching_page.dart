import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp_restapi/features/search/view/controller/search_info_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/presentation/routes/routes.dart';
import '../../../core/widgets/error_view.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<SearchInfoController>().getSearchInfo(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
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
                Expanded(
                  child: GetBuilder<SearchInfoController>(
                    builder: (controller) {
                      final result = controller.result;
                      if (result != null) {
                        return result.fold((l) => ErrorView(l.value),
                            (searchInfo) {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: searchInfo.length,
                              itemBuilder: (BuildContext context, int index) {
                                final news = searchInfo[index];
                                String formatDate(String timestamp) {
                                  DateTime dateTime = DateTime.parse(timestamp);
                                  DateFormat formatter =
                                      DateFormat('d MMMM, yyyy');
                                  return formatter.format(dateTime);
                                }

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.webViewPage,
                                        arguments: searchInfo[index].url);
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
                                                  stops: const [0.0, 0.5, 1.0],
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
                ),
              ],
            ),
          ),
        ));
  }
}
