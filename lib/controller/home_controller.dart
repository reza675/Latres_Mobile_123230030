import 'package:get/get.dart';
import '../service/api_service.dart';

class HomeController extends GetxController {
  final shows = <dynamic>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  Future<void> fetchShows() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await ApiService.getShows(page: 0);
      shows.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Gagal memuat data';
    } finally {
      isLoading.value = false;
    }
  }
}
