import 'package:dio/dio.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/features/news/data/models/NewsResponse.dart';
import 'package:news_app/features/news/data/models/SourcesResponse.dart';

class ApiServices {
  final dio = Dio();

  Future<NewsResponse> getNews(String sourceId, {String? query}) async {
    final response = await dio.get(
      "$baseUrl/v2/everything",
      queryParameters: {
        "apiKey": apiKey,
        "sources": sourceId,
        "q": query,
      },
    );
    final json = response.data;
    final newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }

  Future<SourcesResponse> getSources(String id) async {
    final response = await dio.get(
      "$baseUrl/$endPoint",
      queryParameters: {
        "apiKey": apiKey,
        "category": id,
      },
    );
    final json = response.data;
    final sourcesResponse = SourcesResponse.fromJson(json);
    return sourcesResponse;
  }
}
