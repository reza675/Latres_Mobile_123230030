import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/favorite_controller.dart';
import '../routes/app_routes.dart';

class FavoritePageView extends StatelessWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                'Daftar Favorit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final items = controller.items;
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'Belum ada favorit',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final id = (item['id'] ?? '').toString();
                    final title = (item['title'] ?? '').toString();
                    final rating = (item['rating'] ?? '-').toString();
                    final imageUrl = (item['imageUrl'] ?? '').toString();

                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: imageUrl.isEmpty
                                ? Container(
                                    width: 48,
                                    height: 64,
                                    color: const Color(0xFF2A2A2A),
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  )
                                : Image.network(
                                    imageUrl,
                                    width: 48,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      rating,
                                      style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.deleteById(id, title),
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFFE53C30),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFE53C30),
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed(AppRoutes.home);
          } else if (index == 2) {
            Get.offAllNamed(AppRoutes.profile);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
