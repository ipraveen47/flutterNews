import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/models/slider_model.dart';
import 'package:flutternews/pages/article_view.dart';
import 'package:flutternews/services/news.dart';
import 'package:flutternews/services/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});
  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getSlider();
    getNews();

    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    SliderService slider = SliderService();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news + " News"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length, // ✅ Ensure proper length
                itemBuilder: (context, index) {
                  return AllNewsSection(
                    image: widget.news == "Breaking"
                        ? sliders[index].image!
                        : articles[index].image! ?? "",
                    desc: widget.news == "Breaking"
                        ? sliders[index].description!
                        : articles[index].description! ?? "",
                    title: widget.news == "Breaking"
                        ? sliders[index].title!
                        : articles[index].title! ?? "",
                    url: widget.news == "Breaking"
                        ? sliders[index].url!
                        : articles[index].url! ?? "",
                  );
                })),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String image, desc, title, url;
  AllNewsSection(
      {required this.image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
