import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_apps/app/modules/login/controllers/login_controller.dart';
import 'package:news_apps/splash_screen.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCKsYhsPe3cenY7aibXoIsOwKIuDflf640',
      appId: '1:501060633560:android:93870c3c9d2b1cef6128ad',
      messagingSenderId: '501060633560',
      projectId: 'news-apps-2f38d.appspot.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final loginController = Get.put(LoginController(), permanent: true);
   @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginController.checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() {
            return GetMaterialApp(
              title: 'Flutter Demo',
              initialRoute: loginController.isLogin.isTrue
                  ? Routes.HOME
                  : Routes.LOGIN,
              getPages: AppPages.routes,
            );
          });
        } else {
          return SplashScreen(); // Tampilkan splash screen selama proses pemeriksaan login
        }
      },
    );
  }
}
