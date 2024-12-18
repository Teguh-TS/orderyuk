import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ReviewController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageFile; // Untuk mendukung file Web (sebagai bytes)
  var selectedRating = 0.obs; // Rating yang dipilih
  var reviews = <Map<String, dynamic>>[].obs; // Menyimpan list ulasan

  @override
  void onInit() {
    super.onInit();
    // Load ulasan yang sudah ada dari GetStorage saat pertama kali aplikasi dijalankan
    var storedReviews = GetStorage().read('reviews');
    if (storedReviews != null) {
      reviews.addAll(List<Map<String, dynamic>>.from(storedReviews));
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      if (kIsWeb) {
        // Penanganan khusus untuk platform Web
        final XFile? pickedFile =
            await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImageFile =
              await pickedFile.readAsBytes(); // Simpan file sebagai byte
          selectedImagePath.value =
              pickedFile.name; // Nama file untuk referensi
          Get.snackbar(
            'Success',
            'Image selected successfully!',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Error',
            'No image selected',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Penanganan untuk perangkat non-web
        final XFile? pickedFile =
            await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImagePath.value = pickedFile.path;
          Get.snackbar(
            'Success',
            'Image selected successfully!',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Error',
            'No image selected',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void submitReview() {
    if (selectedImagePath.isEmpty && selectedImageFile == null) {
      Get.snackbar(
        'Error',
        'Please select an image first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Menambahkan review baru ke list
    reviews.add({
      'rating': selectedRating.value,
      'image': kIsWeb ? selectedImageFile : selectedImagePath.value,
    });

    // Menyimpan daftar reviews ke GetStorage
    GetStorage().write('reviews', reviews.toList());

    Get.snackbar(
      'Success',
      'Your review has been submitted!',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Reset fields after submission (optional)
    selectedImagePath.value = '';
    selectedImageFile = null;
    selectedRating.value = 0;
  }
}
