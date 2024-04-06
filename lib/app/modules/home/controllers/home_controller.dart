import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_apps/app/api/news_api.dart';
import 'package:news_apps/app/data/news_model.dart';
import 'package:news_apps/app/routes/app_pages.dart';

class HomeController extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  var articles = <Article>[].obs;

  @override
  void onInit() {
    fetchTopHeadlines();
    super.onInit();
  }

  void fetchTopHeadlines() async {
    try {
      List<Article> fetchedArticles = await NewsApi.getTopHeadlines();
      articles.assignAll(fetchedArticles);
    } catch (e) {
      print('Error fetching top headlines: $e');
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
