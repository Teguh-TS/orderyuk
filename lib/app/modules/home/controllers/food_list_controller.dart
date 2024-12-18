import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FoodListController extends GetxController {
  final SpeechToText _speechToText = SpeechToText();
  var isListening = false.obs;
  var searchQuery = ''.obs;

  // Initialize SpeechToText
  @override
  void onInit() {
    super.onInit();
    _initializeSpeechToText();
  }

  Future<void> _initializeSpeechToText() async {
    bool available = await _speechToText.initialize();
    if (available) {
      print('Speech to text initialized');
    } else {
      print('Speech to text initialization failed');
    }
  }

  // Start listening to user voice
  Future<void> startListening() async {
    if (isListening.value) return; // Jika sudah mendengarkan, jangan mulai lagi

    isListening.value = true;

    await _speechToText.listen(
      onResult: (result) {
        searchQuery.value = result.recognizedWords;

        // Jika perintah selesai (finalResult), lanjutkan mendengarkan untuk perintah berikutnya
        if (result.finalResult) {
          // Memulai kembali untuk mendengarkan perintah baru
          _speechToText.listen(onResult: (result) {
            searchQuery.value = result.recognizedWords;
          });
        }
      },
      listenFor: Duration(seconds: 120), // lama mikrofon mendengarkan
      pauseFor: Duration(seconds: 2), // Waktu tunggu jika tidak ada suara
      partialResults: true, // mendengarkan hasil sementara
    );
  }

  // Stop listening
  void stopListening() {
    isListening.value = false;
    _speechToText.stop();
  }

  // Filter food list based on query
  List<dynamic> filterCategories(List<dynamic> categories) {
    if (searchQuery.isEmpty) {
      return categories;
    }
    return categories
        .where((category) => category.strCategory
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}
