import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makanyuk/app/modules/home/controllers/order_controller.dart';

class OrderView extends StatelessWidget {
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pesanan'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/order_background.png'), // Path ke gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(() {
            if (orderController.orderList.isEmpty) {
              return Center(child: Text('Belum ada pesanan'));
            } else {
              return ListView.builder(
                itemCount: orderController.orderList.length,
                itemBuilder: (context, index) {
                  var order = orderController.orderList[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      leading: Image.network(order.strCategoryThumb),
                      title: Text(order.strCategory),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          orderController.removeOrder(order);
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
