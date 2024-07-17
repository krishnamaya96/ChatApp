import 'package:chat_app/Controller/login_Controller.dart';
import 'package:get/get.dart';

import '../Controller/chatListController.dart';
import '../Controller/userController_get.dart';

class initialBinding extends Bindings{
  @override
  void dependencies() {
    //here we init controllers..
    Get.put(UserController());
  //  Get.put(ChatRoomController());
  Get.lazyPut(() => LoginController());
  }

}