import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_apps/app/data/news_model.dart';
import 'package:news_apps/app/modules/detail/controllers/detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments as Article;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                onPressed: () {
                  controller.toggleBookmark(article);
                },
                icon: controller.isBookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_border),
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(article.urlToImage),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://www.w3schools.com/w3images/avatar2.png"),
                ),
                const SizedBox(width: 16),
                Text(
                  article.author.isEmpty ? 'Unknown' : article.author,
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Published At: ${article.publishedAt}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              article.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Content: ${article.content}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _launchURL(article.url),
              child: Text(
                'Source: ${article.url}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun widget gambar
  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(imageUrl);
    } else {
      return Image.network(
          "https://i.pinimg.com/736x/26/91/f2/2691f2fa1a0f078f5f274edf7fea6763.jpg"); // Return an empty SizedBox if imageUrl is null or empty
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
