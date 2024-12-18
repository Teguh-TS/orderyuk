import 'dart:io';
import 'dart:typed_data'; // Untuk Uint8List
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // RatingBar import
import '../controllers/review_controller.dart';

class ReviewView extends StatelessWidget {
  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol untuk memilih gambar
              ElevatedButton(
                onPressed: controller.pickImage,
                child: Text('Pick an image'),
              ),
              SizedBox(height: 20),
              // Menampilkan gambar berdasarkan platform
              Obx(() {
                if (controller.selectedImageFile != null && kIsWeb) {
                  // Untuk Web, menggunakan Image.memory untuk menampilkan gambar
                  return Image.memory(controller.selectedImageFile!);
                } else if (controller.selectedImagePath.isNotEmpty && !kIsWeb) {
                  // Untuk perangkat non-web, menggunakan Image.file
                  return Image.file(File(controller.selectedImagePath.value));
                } else {
                  return Text('No image selected');
                }
              }),
              SizedBox(height: 20),
              // Rating dengan bintang menggunakan RatingBar
              Obx(() {
                return RatingBar.builder(
                  initialRating: controller.selectedRating.value.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    controller.selectedRating.value = rating.toInt();
                  },
                );
              }),
              SizedBox(height: 20),
              // Tombol untuk mengirimkan ulasan
              ElevatedButton(
                onPressed: controller.submitReview,
                child: Text('Submit Review'),
              ),
              SizedBox(height: 20),
              // Menampilkan daftar ulasan
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    var review = controller.reviews[index];
                    // Menangani gambar pada list ulasan
                    var reviewImage = review['image'];
                    Widget imageWidget;
                    if (reviewImage is String) {
                      // Jika gambar adalah path file (untuk non-web)
                      imageWidget = Image.file(File(reviewImage));
                    } else if (reviewImage is Uint8List) {
                      // Jika gambar adalah byte array (untuk web)
                      imageWidget = Image.memory(reviewImage);
                    } else {
                      imageWidget = Text('No image');
                    }

                    return Card(
                      child: ListTile(
                        leading: imageWidget,
                        title: Text('Rating: ${review['rating']}'),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
