import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  // Observables untuk menyimpan data lokasi
  var latitude = Rxn<double>();
  var longitude = Rxn<double>();
  var address = Rxn<String>();
  var isLoading = false.obs;
  var userMarker = Rxn<Marker>();
  var googleMapController = Rxn<GoogleMapController>();

  // Menambahkan onMapCreated untuk menangani event peta selesai dibuat
  void onMapCreated(GoogleMapController controller) {
    googleMapController.value = controller;
  }

  // Mendapatkan lokasi berdasarkan input manual
  Future<void> setLocationManually(
      double inputLatitude, double inputLongitude) async {
    isLoading.value = true;

    try {
      latitude.value = inputLatitude;
      longitude.value = inputLongitude;

      // Mendapatkan alamat menggunakan geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        inputLatitude,
        inputLongitude,
      );
      Placemark place = placemarks[0];
      address.value =
          '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

      // Tambahkan marker untuk lokasi pengguna
      userMarker.value = Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(latitude.value!, longitude.value!),
        infoWindow: InfoWindow(
          title: 'Lokasi Manual',
          snippet: address.value,
        ),
      );

      // Pindahkan kamera ke lokasi yang diatur
      if (googleMapController.value != null) {
        await googleMapController.value!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude.value!, longitude.value!),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menetapkan lokasi: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk membuka Google Maps dengan URL
  Future<void> openGoogleMaps() async {
    final url =
        'https://www.google.com/maps?q=${latitude.value},${longitude.value}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        'Error',
        'Tidak dapat membuka Google Maps.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
