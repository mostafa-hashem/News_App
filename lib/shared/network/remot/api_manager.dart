import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/models/NewsResponse.dart';
import '../../../models/SoursesResponse.dart';
import '../../components/constans.dart';

class ApiManager {
  static Future<SoursesResponse> getSources(String id) async {
    Uri URL = Uri.https(BASE_URL, END_POINT, {"apiKey": ApiKey, "category" : id});
    Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);
    SoursesResponse soursesResponse = SoursesResponse.fromJson(jsonResponse);
    return soursesResponse;
  }

  static Future<NewsResponse> getNewsData(String sourceID, String query) async {
    Uri URL = Uri.https(BASE_URL, "/v2/everything", {
      "apiKey": ApiKey,
      "sources": sourceID,
      "q": query,
    });

    Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(jsonResponse);
    return newsResponse;
  }
}
