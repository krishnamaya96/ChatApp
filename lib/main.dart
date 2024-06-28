import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/Screen/spalsh_screen.dart';
import 'package:chat_app/bindings/initial_bindings.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/webSocket/web_socket.dart';
import 'package:chat_app/webSocket/web_socket_service_factory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_page_one.dart';



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
  // final WebSocketService webSocketService = createWebSocketService('ws://127.0.0.1:8000/ws/chat/roomName/');
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
        GetPage(name: Routes.SPLASH_SCREEN, page: () => SplashScreen() ),
        //WebSocketExamplePage(webSocketService: webSocketService)

      ],
      initialRoute: Routes.SPLASH_SCREEN,


     // home: WelcomePage(),
    );
  }
}

class Routes{
  static const String SPLASH_SCREEN = '/';

}


