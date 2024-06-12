import 'package:chat_app/Controller/login_Controller.dart';
import 'package:get/get.dart';

class initialBinding extends Bindings{
  @override
  void dependencies() {
    //here we init controllers..
  Get.lazyPut(() => LoginController());
  }

}