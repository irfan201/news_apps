import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_apps/app/data/news_bookmark_model.dart';
import 'package:news_apps/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:news_apps/app/routes/app_pages.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return const Center(
            child: Text(
              'No bookmarks yet.',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.bookmarks.length,
            itemBuilder: (context, index) {
              NewsBookmark bookmark = controller.bookmarks[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.FAVORITE_DETAIL, arguments: bookmark);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: bookmark.urlToImage.isNotEmpty
                            ? NetworkImage(bookmark.urlToImage)
                            : const NetworkImage(
                                'https://i.pinimg.com/736x/26/91/f2/2691f2fa1a0f078f5f274edf7fea6763.jpg'),
                        fit: BoxFit
                            .fill, // Set gambar untuk menampilkan sepenuhnya tanpa dipotong
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Text(
                            bookmark.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
