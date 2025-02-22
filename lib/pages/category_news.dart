import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/show_category.dart';
import 'package:flutternews/pages/article_view.dart';
import 'package:flutternews/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _isLoading = true;

  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading
          : categories.isEmpty
              ? const Center(
                  child: Text(
                      "No news found in this category")) // Handle empty case
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: categories.length, // ✅ Ensure proper length
                      itemBuilder: (context, index) {
                        return ShowCategory(
                          image: categories[index].image ?? "",
                          desc:
                              categories[index].description ?? "No description",
                          title: categories[index].title ?? "No title",
                          url: categories[index].url ?? "",
                        );
                      }),
                ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, desc, title, url;
  ShowCategory(
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
