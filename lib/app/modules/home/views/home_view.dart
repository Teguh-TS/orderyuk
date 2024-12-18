import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makanyuk/app/modules/home/views/location_view.dart';
import 'order_view.dart';
import 'review_view.dart';
import 'order_ready_view.dart';
import 'web_view_page.dart';
import 'food_list_view.dart'; // Import FoodListView untuk menu makanan
import 'package:makanyuk/app/modules/home/controllers/location_controller.dart';
import 'package:makanyuk/app/modules/home/controllers/connectivity_controller.dart'; // Import ConnectivityController

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final LocationController locationController = Get.put(LocationController());
  final ConnectivityController connectivityController = Get.put(
      ConnectivityController()); // Tambahkan controller untuk konektivitas
  int _currentIndex = 0;

  bool isLocationClicked = false;

  final List<Widget> pages = [
    HomeContentView(), // Menampilkan HomeContentView
    FoodListView(), // Menampilkan menu makanan dengan memanggil FoodListView
    OrderView(),
    ReviewView(),
    OrderReadyView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Order App'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: isLocationClicked ? Colors.blue : Colors.grey,
            ),
            onPressed: () async {
              setState(() {
                isLocationClicked = true;
              });
              await locationController;
              showDialog(
                context: context,
                builder: (context) => LocationView(),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        // Pantau perubahan konektivitas menggunakan Obx
        if (!connectivityController.isConnected.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 80, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  "Koneksi Anda Terputus",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            ),
          );
        }
        return pages[_currentIndex]; // Tampilkan halaman sesuai dengan indeks
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant_menu,
              color: _currentIndex == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'Makanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _currentIndex == 2 ? Colors.blue : Colors.grey,
            ),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rate_review,
              color: _currentIndex == 3 ? Colors.blue : Colors.grey,
            ),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: _currentIndex == 4 ? Colors.blue : Colors.grey,
            ),
            label: 'Order Ready',
          ),
        ],
      ),
    );
  }
}

class HomeContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "MakanYuk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.fastfood, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'lib/assets/resto2.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Selamat Datang di App MakanYuk",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "MakanYuk adalah sebuah aplikasi order makanan untuk memudahkan kalian semua tanpa repot-repot datang ke kasir. Cukup pesan dan pilih menu melalui aplikasi MakanYuk. Kami juga menyediakan 2 pilihan pelayanan, pesanan anda akan diantar oleh waiters atau anda mengambil pesanan anda sendiri setelah terdapat panggilan dari pihak resto.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigasi ke WebView
                Get.to(() => WebViewPage(url: 'https://www.themealdb.com'));
              },
              child: Column(
                children: [
                  Icon(Icons.web, size: 40, color: Colors.blue),
                  Text(
                    "Visit Us",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
