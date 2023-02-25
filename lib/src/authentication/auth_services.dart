import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_login/src/screens/widgets/gnav_bottom_bar.dart';


class AuthService {
  // Google sign in
  signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) => Get.to(const GnavBottomBar()));
  }
  signOutWithGoogle() async {
    if (await GoogleSignIn().isSignedIn()) {
      GoogleSignIn().signOut();
    }
  }
}
