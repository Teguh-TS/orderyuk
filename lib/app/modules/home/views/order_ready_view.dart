import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_ready_controller.dart';

class OrderReadyView extends StatelessWidget {
  final OrderReadyController controller = Get.put(OrderReadyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesanan Selesai')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menampilkan daftar nomor antrian
            Expanded(
              child: ListView.builder(
                itemCount: controller.audioFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Nomor Antrian: ${index + 1}'),
                    trailing: Icon(Icons.play_arrow),
                    onTap: () => controller.playOrderReadySound(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
