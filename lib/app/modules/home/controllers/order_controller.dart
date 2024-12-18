import 'package:get/get.dart';
import '../../../data/models/category.dart';

class OrderController extends GetxController {
  var orderList = <Category>[].obs;

  void addOrder(Category category) {
    orderList.add(category);
  }

  void removeOrder(Category category) {
    orderList.remove(category);
  }

  void clearOrders() {
    orderList.clear();
  }
}
