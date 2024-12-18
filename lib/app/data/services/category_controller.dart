import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categories = <Category>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        DemoMod2 demoMod2 = DemoMod2.fromJson(data);
        categories.value = demoMod2.categories;
      }
    } finally {
      isLoading(false);
    }
  }
}
