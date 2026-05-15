import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteController extends GetxController {
  final items = <Map<String, dynamic>>[].obs;

  late final Box<Map> _box;
  VoidCallback? _boxListener;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box<Map>('favorites');
    _syncItems();
    _boxListener = () => _syncItems();
    _box.listenable().addListener(_boxListener!);
  }

  @override
  void onClose() {
    if (_boxListener != null) {
      _box.listenable().removeListener(_boxListener!);
    }
    super.onClose();
  }

  void deleteById(String id, String title) {
    _box.delete(id);
    Get.snackbar(
      'Favorit Dihapus',
      'Film dengan $id bernama $title telah dihapus dari daftar favorit',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  void _syncItems() {
    final keys = _box.keys.toList().cast<String>();
    final data = <Map<String, dynamic>>[];
    for (final key in keys) {
      final item = Map<String, dynamic>.from(_box.get(key) ?? {});
      item['id'] = key;
      data.add(item);
    }
    items.assignAll(data);
  }
}
