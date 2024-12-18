import 'dart:html' as html;
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:get/get.dart';

class OrderReadyController extends GetxController {
  // Daftar audio berdasarkan nomor antrian
  final List<String> audioFiles = [
    'web/assets/order_ready1.ogg',
    'web/assets/order_ready2.ogg',
    'web/assets/order_ready3.ogg',
    'web/assets/order_ready4.ogg',
    'web/assets/order_ready5.ogg',
  ];

  // Fungsi untuk memutar audio berdasarkan nomor antrian
  void playOrderReadySound(int index) {
    if (kIsWeb) {
      // Menghentikan audio yang sedang diputar jika ada
      html.AudioElement? currentAudio = html.document
          .getElementById('order_ready_audio') as html.AudioElement?;
      currentAudio?.pause();
      currentAudio?.remove();

      // Membuat elemen audio baru untuk audio yang dipilih
      html.AudioElement audio = html.AudioElement(audioFiles[index])
        ..id = 'order_ready_audio'
        ..load();

      // Memainkan audio
      audio.play();

      // Menampilkan notifikasi
      Get.snackbar('Info', 'Pesanan selesai, suara diputar.');
    } else {
      // Logika untuk platform selain Web (misalnya Android/iOS)
      // Gunakan audioplayers atau mekanisme lainnya
    }
  }
}
