import 'package:elecciones/pages/alerta_page.dart';
import 'package:elecciones/pages/carga_page.dart';
import 'package:elecciones/pages/home_page.dart';
import 'package:elecciones/pages/mesa_page.dart';
import 'package:elecciones/pages/principal_page.dart';
//import 'package:elecciones/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      // home: LoginPage(),
      home: controller.page,
      getPages: [
        GetPage(name: "home", page: () => HomePage()),
        GetPage(name: "principal", page: () => PrincipalPage()),
        GetPage(name: "carga", page: () => CargaPage()),
        GetPage(name: "alerta", page: () => ALertaPage()),
        GetPage(name: "mesa", page: () => MesaPage()),
      ],
    );
  }
}
