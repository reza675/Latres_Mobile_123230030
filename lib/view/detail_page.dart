import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/detail_controller.dart';

class DetailPageView extends StatelessWidget {
  const DetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text('Detail', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          );
        }

        final imageUrl = controller.imageUrl;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: imageUrl == null
                    ? Container(
                        color: const Color(0xFF2A2A2A),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 500,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  controller.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text(
                      controller.rating,
                      style: TextStyle(color: Colors.grey.shade300),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        controller.genresText.isEmpty
                            ? '-'
                            : controller.genresText,
                        style: TextStyle(color: Colors.grey.shade400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53C30),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.play_arrow),
                              SizedBox(width: 8),
                              Text('Nonton'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Obx(() {
                      final isFavorite = controller.isFavorite.value;
                      return InkWell(
                        onTap: controller.toggleFavorite,
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 36, 36, 36),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? const Color(0xFFE53C30)
                                : Colors.white,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 6),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Text(
                  controller.summary.isEmpty ? '-' : controller.summary,
                  style: TextStyle(color: Colors.grey.shade300, height: 1.5),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
