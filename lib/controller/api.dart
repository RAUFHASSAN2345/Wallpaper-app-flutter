import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/catg_model.dart';
import 'package:wallpaper_app/model/photo_model.dart';

class ApiOperations {
  static List<PhotoModel> trendgWallp = [];
  static List<PhotoModel> searchWalpaper = [];
  static List<CategoryModel> cateogryModelList = [];

  // ignore: non_constant_identifier_names
  static Future<List<PhotoModel>> getTren_Wallp() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated'), headers: {
      "Authorization":
          'XMg35adwgphMcoHTwCI9U1VgnqyUAjcIM7yAAy2SCzWux45ylDVeTlPI'
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      photos.forEach((element) {
        trendgWallp.add(PhotoModel.fromApitoApp(element));
      });
    });
    return trendgWallp;
  }

  static searchWallpaper(String search) async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$search&per_page=30&page=1'),
        headers: {
          "Authorization":
              'XMg35adwgphMcoHTwCI9U1VgnqyUAjcIM7yAAy2SCzWux45ylDVeTlPI'
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      searchWalpaper.clear();
      for (var element in photos) {
        searchWalpaper.add(PhotoModel.fromApitoApp(element));
      }
    });
    return searchWalpaper;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryName.forEach((catName) async {
      final random = Random();

      PhotoModel photoModel =
          (await searchWallpaper(catName))[0 + random.nextInt(11 - 0)];

      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
