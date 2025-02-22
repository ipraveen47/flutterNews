import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/slider_model.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/pages/all_news.dart';
import 'package:flutternews/pages/category_news.dart';
import 'package:flutternews/services/data.dart';
import 'package:flutternews/services/news.dart';
import 'package:flutternews/services/slider_data.dart';
import 'package:flutternews/widgets/blog_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _isLoading = true;
  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();

    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _isLoading = false;
    });
  }

  getSlider() async {
    SliderService slider = SliderService();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              'News',
              style: TextStyle(
                color: Color.fromARGB(255, 196, 2, 230),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories - Horizontal Scroll
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          image: categories[index].image,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Breaking News Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Breaking News!!!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllNews(news: "Breaking")));
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Image Carousel Slider
                  CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return buildImage(
                          sliders[index].image!, index, sliders[index].title!);
                    },
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Page Indicator
                  buildIndicator(),
                  const SizedBox(height: 20),

                  // Trending News Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending News',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllNews(news: "Breaking")));
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Blog List (Scrollable inside SingleChildScrollView)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        url: articles[index].url!,
                        imageUrl: articles[index].image!,
                        title: articles[index].title!,
                        desc: articles[index].description!,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                imageUrl: image,
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 200.0),
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ExpandingDotsEffect(
          activeDotColor: Color.fromARGB(255, 3, 51, 91),
          dotWidth: 10,
          dotHeight: 10,
        ),
      );
}

class CategoryTile extends StatelessWidget {
  final String? image, categoryName;
  const CategoryTile({this.categoryName, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName!)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image!,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
