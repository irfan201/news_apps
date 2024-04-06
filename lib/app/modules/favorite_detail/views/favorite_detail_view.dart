import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_apps/app/data/news_bookmark_model.dart';
import 'package:news_apps/app/modules/favorite_detail/controllers/favorite_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteDetailView extends GetView<FavoriteDetailController> {
  const FavoriteDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsBookmark newsBookmark = Get.arguments as NewsBookmark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(newsBookmark.urlToImage),
            const SizedBox(height: 16),
            Text(
              newsBookmark.title,
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
                  newsBookmark.author.isEmpty ? 'Unknown' : newsBookmark.author,
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Published At: ${newsBookmark.publishedAt}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              newsBookmark.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Content: ${newsBookmark.content}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _launchURL(newsBookmark.url),
              child: Text(
                'Source: ${newsBookmark.url}',
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

  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(imageUrl);
    } else {
      return Image.network(
          "https://i.pinimg.com/736x/26/91/f2/2691f2fa1a0f078f5f274edf7fea6763.jpg");
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
