import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_apps/app/data/news_model.dart';

class NewsApi {
  static Future<List<Article>> getTopHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=74642b1701404fb482443cfc6e2d6239';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Article> articles = [];
        for (var item in jsonData['articles']) {
          articles.add(Article.fromJson(item));
        }
        return articles;
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Failed to load top headlines: $e');
    }
  }
}
