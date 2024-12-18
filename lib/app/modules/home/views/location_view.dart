import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makanyuk/app/modules/home/controllers/location_controller.dart';

class LocationView extends StatelessWidget {
  final LocationController locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        title: Text(
          'Lokasi Resto',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Tetapkan nilai latitude dan longitude
                  double predefinedLatitude =
                      -7.9210029215075615; //nilai latitude
                  double predefinedLongitude =
                      112.59921369258426; //nilai longitude

                  locationController.setLocationManually(
                      predefinedLatitude, predefinedLongitude);
                },
                child: Text(
                  'Dapatkan Lokasi Lokasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Menampilkan hasil lokasi jika sudah diset
              if (locationController.latitude.value != null &&
                  locationController.longitude.value != null)
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          locationController.address.value ?? 'Tidak tersedia',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Latitude: ${locationController.latitude.value}',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Longitude: ${locationController.longitude.value}',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 30),
              // Tombol untuk membuka Google Maps
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: locationController.latitude.value != null &&
                        locationController.longitude.value != null
                    ? () {
                        locationController.openGoogleMaps();
                      }
                    : null,
                child: Text(
                  'Buka di Google Maps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Tutup', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      );
    });
  }
}
