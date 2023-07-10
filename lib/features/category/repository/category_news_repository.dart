import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsapp_restapi/features/home_page/model/category_model.dart';
import 'package:newsapp_restapi/features/home_page/repository/news_info_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NewsCategoryRepository {
  Future<Either<NetworkException, List<NewsCategoryModel>>> getNewsCategoryInfo(
      String category) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    const apiKey = "4f352006e53b4c808ed62567356704f2";
    dio.options.baseUrl = "https://newsapi.org/v2";
    try {
      final response = await dio
          .get("/top-headlines/sources?category=$category&apiKey=$apiKey");

      final categoryNewsInfo = response.data["sources"];
      final newsCategoryInfoList = categoryNewsInfo
          .map<NewsCategoryModel>(
              (dataJson) => NewsCategoryModel.fromJson(dataJson))
          .toList();

      return right(newsCategoryInfoList);
    } catch (e) {
      if (e is DioException && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }
}
