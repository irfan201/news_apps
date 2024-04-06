import 'package:get/get.dart';
import 'package:news_apps/app/data/news_bookmark_model.dart';
import 'package:news_apps/app/data/database_helper.dart';
import 'package:news_apps/app/data/news_model.dart';

class DetailController extends GetxController {
  final _isBookmarked = false.obs;
  bool get isBookmarked => _isBookmarked.value;

  @override
  void onInit() {
    super.onInit();
    final Article article = Get.arguments as Article;
    _loadBookmarkStatus(article);
  }

  void _loadBookmarkStatus(Article article) async {
    _isBookmarked.value =
        await DatabaseHelper.instance.isArticleBookmarked(article.url.hashCode);
  }

  void toggleBookmark(Article article) async {
    if (isBookmarked) {
      await _removeBookmark(article);
      Get.snackbar("Menghapus bookmark", "Berhasil menghapus bookmark");
    } else {
      await _saveBookmark(article);
      Get.snackbar("Menambahkan bookmark", "Berhasil menambahkan bookmark");
    }
    _isBookmarked.toggle();
  }

  Future<void> _saveBookmark(Article article) async {
    final newsBookmark = NewsBookmark(
      id: article.url.hashCode,
      title: article.title,
      author: article.author,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
    await DatabaseHelper.instance.insertNewsBookmark(newsBookmark);
  }

  Future<void> _removeBookmark(Article article) async {
    await DatabaseHelper.instance.deleteNewsBookmark(article.url.hashCode);
  }
}
