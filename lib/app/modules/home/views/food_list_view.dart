import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makanyuk/app/data/services/category_controller.dart';
import '../controllers/food_list_controller.dart';
import '../controllers/order_controller.dart';

class FoodListView extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final OrderController orderController = Get.put(OrderController());
  final FoodListController foodListController = Get.put(FoodListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Makanan'),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                foodListController.isListening.value
                    ? Icons.mic
                    : Icons.mic_none,
              ),
              onPressed: () {
                if (foodListController.isListening.value) {
                  foodListController.stopListening();
                } else {
                  foodListController.startListening();
                }
              },
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/food_list_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(() {
            if (categoryController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              // Filter categories based on search query
              var filteredCategories = foodListController
                  .filterCategories(categoryController.categories);

              // Menggunakan ListView.builder untuk menampilkan kategori makanan yang telah difilter
              return ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  var category = filteredCategories[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      leading: Image.network(category.strCategoryThumb),
                      title: Text(category.strCategory),
                      subtitle: Text(category.strCategoryDescription),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          orderController.addOrder(category);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
