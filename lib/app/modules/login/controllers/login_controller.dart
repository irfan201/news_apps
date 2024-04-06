import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_apps/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  UserCredential? _userCredential;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> checkLogin() async {
    User? user = auth.currentUser;
    if (user != null) {
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
  }

  Future<void> login() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _user = value);
      print("User: $_user");

      final isSignedIn = await _googleSignIn.isSignedIn();

      if (isSignedIn) {
        print('User is signed in');

        final googleSignInAuthentication = await _user!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => _userCredential = value);

        isLogin.value = true;
        Get.offAllNamed(Routes.HOME);
      }
    } catch (error) {
      print(error);
    }
  }
}
