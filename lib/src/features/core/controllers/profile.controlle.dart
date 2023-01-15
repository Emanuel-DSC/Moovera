import 'package:get/get.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';
import 'package:movie_login/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final phoneNo = _authRepo.firebaseUser.value?.phoneNumber;
    if (phoneNo != null) {
      return _userRepo.getUserDetails(phoneNo);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }
}
