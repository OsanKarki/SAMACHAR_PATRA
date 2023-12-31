import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../home_page/model/news_model.dart';
import '../../home_page/repository/news_info_repository.dart';

class NewsDetailRepository {
  Future<Either<NetworkException, NewsModel>> getNewsDetail(String id) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    const apiKey = "4f352006e53b4c808ed62567356704f2";

    dio.options.baseUrl = "https://newsapi.org/v2";
    try {
      final response = await dio.get(
          "https://newsapi.org/v2/everything?sources=$id&apiKey=$apiKey");

      final newsInfo = response.data["articles"];
      print(newsInfo);
      final newsModelList = NewsModel.fromJson(newsInfo);

      return right(newsModelList);
    } catch (e) {
      if (e is DioException && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }
}
