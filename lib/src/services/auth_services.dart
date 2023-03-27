import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/screens/on_boarding/on_boarding_screen.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  // will be load when app launches and this function will be called and set the firebaseuser state
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  //setting initial screen on load
  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const OnBoardingScreen()) : const GnavBottomBar();
  }

  Future<void> logout() async => await _auth.signOut();
}
