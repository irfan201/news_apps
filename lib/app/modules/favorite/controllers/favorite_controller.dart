import 'package:get/get.dart';
import 'package:news_apps/app/data/database_helper.dart';
import 'package:news_apps/app/data/news_bookmark_model.dart';

class FavoriteController extends GetxController {
  final List<NewsBookmark> bookmarks = <NewsBookmark>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    try {
      final List<NewsBookmark> bookmarkList =
          await DatabaseHelper.instance.getAllNewsBookmarks();
      bookmarks.assignAll(bookmarkList);
    } catch (e) {
      print('Error fetching bookmarks: $e');
    }
  }

  Future<void> removeBookmark(int id) async {
    try {
      await DatabaseHelper.instance.deleteNewsBookmark(id);
      bookmarks.removeWhere((bookmark) => bookmark.id == id);
    } catch (e) {
      print('Error removing bookmark: $e');
    }
  }
}
