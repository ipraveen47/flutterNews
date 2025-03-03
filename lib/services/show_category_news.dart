import 'dart:convert';

import 'package:flutternews/models/show_category.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url =
        "Your API KEy";

    try {
      final response = await http.get(Uri.parse(url));
      print('response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('articles')) {
          List<ShowCategoryModel> loadNews = [];

          for (var element in jsonData['articles']) {
            if (element['image'] != null && element['description'] != null) {
              loadNews.add(ShowCategoryModel(
                title: element['title'],
                description: element['description'],
                url: element['url'],
                image: element['image'],
                content: element['content'],
                author: element['author'],
              ));
            }
          }

          categories = loadNews;
        }
      } else {
        throw Exception("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}
