import 'dart:convert';

import 'package:flutternews/models/slider_model.dart';
import 'package:http/http.dart' as http;

class SliderService {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=10&apikey=cdaa96121f34b842195fc5c7be3f7469";

    try {
      final response = await http.get(Uri.parse(url));
      print('response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('articles')) {
          List<SliderModel> loadNews = [];

          for (var element in jsonData['articles']) {
            if (element['image'] != null && element['description'] != null) {
              loadNews.add(SliderModel(
                title: element['title'],
                description: element['description'],
                url: element['url'],
                image: element['image'],
                content: element['content'],
                author: element['author'],
              ));
            }
          }

          sliders = loadNews;
        }
      } else {
        throw Exception("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}
