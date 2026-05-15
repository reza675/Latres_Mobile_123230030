import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../service/api_service.dart';

class DetailController extends GetxController {
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final detail = Rxn<Map<String, dynamic>>();
  final isFavorite = false.obs;

  late final Box<Map> _box;
  VoidCallback? _boxListener;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box<Map>('favorites');
    _boxListener = () => _syncFavoriteState();
    _box.listenable().addListener(_boxListener!);
    _loadDetail();
  }

  @override
  void onClose() {
    if (_boxListener != null) {
      _box.listenable().removeListener(_boxListener!);
    }
    super.onClose();
  }

  Future<void> _loadDetail() async {
    final showId = Get.arguments as int?;
    if (showId == null) {
      errorMessage.value = 'Data tidak ditemukan';
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await ApiService.getShowDetail(showId);
      detail.value = Map<String, dynamic>.from(result as Map);
      _syncFavoriteState();
    } catch (e) {
      errorMessage.value = 'Gagal memuat detail';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite() {
    final data = detail.value;
    final showId = _showId;
    if (data == null || showId == null || showId.isEmpty) {
      return;
    }

    if (_box.containsKey(showId)) {
      _box.delete(showId);
      Get.snackbar(
        'Favorit Dihapus',
        '$title telah dihapus dari daftar favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    } else {
      _box.put(showId, {
        'id': showId,
        'title': title,
        'imageUrl': imageUrl ?? '',
        'summary': summary,
        'genre': genresText,
        'rating': rating,
      });
      Get.snackbar(
        'Favorit Ditambah',
        '$title berhasil disimpan ke favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    }
    _syncFavoriteState();
  }

  void _syncFavoriteState() {
    final showId = _showId;
    if (showId == null || showId.isEmpty) {
      isFavorite.value = false;
      return;
    }
    isFavorite.value = _box.containsKey(showId);
  }

  String? get _showId {
    final data = detail.value;
    if (data == null) {
      return null;
    }
    return (data['id'] ?? '').toString();
  }

  String get title {
    final data = detail.value;
    return (data?['name'] ?? '').toString();
  }

  String get rating {
    final data = detail.value;
    return (data?['rating']?['average'] ?? '-').toString();
  }

  String get genresText {
    final data = detail.value;
    final list = (data?['genres'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    return list.join(', ');
  }

  String get summary {
    final data = detail.value;
    return _stripHtml((data?['summary'] ?? '').toString());
  }

  String? get imageUrl {
    final data = detail.value;
    final original = data?['image']?['original']?.toString();
    final medium = data?['image']?['medium']?.toString();
    return original ?? medium;
  }

  String _stripHtml(String input) {
    return input.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}
