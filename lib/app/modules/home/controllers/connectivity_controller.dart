import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  var isConnected = true.obs;

  late final Stream<ConnectivityResult> _connectivityStream;

  @override
  void onInit() {
    super.onInit();
    _connectivityStream =
        Connectivity().onConnectivityChanged as Stream<ConnectivityResult>;
    _connectivityStream.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
    });

    _checkInitialConnectivity();
  }

  void _checkInitialConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
  }
}
