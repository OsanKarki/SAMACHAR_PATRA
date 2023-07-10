import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../model/category_model.dart';
import '../model/news_model.dart';

class NewsInfoRepository {
  Future<Either<NetworkException, List<NewsModel>>> getNewsInfo(
      int page) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    const apiKey = "4f352006e53b4c808ed62567356704f2";

    dio.options.baseUrl = "https://newsapi.org/v2";
    try {
      final response = await dio
          .get("/everything?q=bitcoin&pageSize=15&page=$page&apiKey=$apiKey");

      final newsInfo = response.data["articles"];
      final newsModelList = newsInfo
          .map<NewsModel>((dataJson) => NewsModel.fromJson(dataJson))
          .toList();

      return right(newsModelList);
    } catch (e) {
      if (e is DioException && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }

  Future<Either<NetworkException, List<NewsModel>>> getTopNewsInfo() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    const apiKey = "4f352006e53b4c808ed62567356704f2";

    dio.options.baseUrl = "https://newsapi.org/v2";
    try {
      final response =
          await dio.get("/top-headlines?country=us&pageSize=10&apiKey=$apiKey");

      final newsInfo = response.data["articles"];
      final newsModelList = newsInfo
          .map<NewsModel>((dataJson) => NewsModel.fromJson(dataJson))
          .toList();

      return right(newsModelList);
    } catch (e) {
      if (e is DioException && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }

  Future<Either<NetworkException, List<NewsCategoryModel>>>
      getNewsCategoryName() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    const apiKey = "4f352006e53b4c808ed62567356704f2";
    dio.options.baseUrl = "https://newsapi.org/v2";
    try {
      final response = await dio.get("/top-headlines/sources?apiKey=$apiKey");

      final newsInfo = response.data["sources"];
      final newsCategoryNameList = newsInfo
          .map<NewsCategoryModel>(
              (dataJson) => NewsCategoryModel.fromJson(dataJson))
          .toList();

      return right(newsCategoryNameList);
    } catch (e) {
      if (e is DioException && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }

}

class NetworkException {
  String value;

  NetworkException(this.value);
}
