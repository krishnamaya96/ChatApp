import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId.value = user.uid;
      print('Current User ID: ${currentUserId.value}'); // Debug print
    }
    else{
      print('no user logged in');
    }
  }
}

