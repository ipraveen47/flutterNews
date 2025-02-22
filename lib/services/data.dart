import 'package:flutternews/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];

  category.add(CategoryModel(
    categoryName: "Business",
    image: "assets/business.jpg",
  ));

  category.add(CategoryModel(
    categoryName: "Entertainment",
    image: "assets/entertainment.jpg",
  ));

  category.add(CategoryModel(
    categoryName: "General",
    image: "assets/general.jpg",
  ));

  category.add(CategoryModel(
    categoryName: "Health",
    image: "assets/health.jpg",
  ));

  category.add(CategoryModel(
    categoryName: "Science",
    image: "assets/science.jpg",
  ));

  category.add(CategoryModel(
    categoryName: "Sports",
    image: "assets/sport.jpg",
  ));

  return category;
}
