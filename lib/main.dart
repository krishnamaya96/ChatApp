import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/Screen/mobile_verification.dart';
import 'package:chat_app/Screen/settings_page.dart';
import 'package:chat_app/Screen/spalsh_screen.dart';
import 'package:chat_app/Screen/user_info.dart';
import 'package:chat_app/Sub_Screens/accounts/change_number.dart';
import 'package:chat_app/Sub_Screens/accounts/change_number2.dart';
import 'package:chat_app/Sub_Screens/accounts/delete_account.dart';
import 'package:chat_app/Sub_Screens/accounts/email_address.dart';
import 'package:chat_app/Sub_Screens/accounts/pass_key.dart';
import 'package:chat_app/Sub_Screens/accounts/request_account.dart';
import 'package:chat_app/Sub_Screens/accounts/security_notification.dart';
import 'package:chat_app/Sub_Screens/accounts/two_step_ver.dart';
import 'package:chat_app/Sub_Screens/linked_device.dart';
import 'package:chat_app/bindings/initial_bindings.dart';
import 'package:chat_app/elements/bottom_nav.dart';
import 'package:chat_app/elements/country_list.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screen/otp_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Country sampleCountry = Country(name: 'INDIA', code: 'IN');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: initialBinding(),
      getPages: [
        GetPage(name: Routes.SPLASH_SCREEN, page: () => SplashScreen()),

      ],
      initialRoute: Routes.SPLASH_SCREEN,


     // home: WelcomePage(),
    );
  }
}

class Routes{
  static const String SPLASH_SCREEN = '/';

}


