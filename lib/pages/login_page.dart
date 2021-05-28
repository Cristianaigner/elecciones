





import 'package:elecciones/controllers/user_controller.dart';

import 'package:elecciones/widgets/labels.dart';
import 'package:elecciones/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: GetBuilder<UserController>(
        init: UserController(),
              builder:(_)=> 
              SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Logo( titulo: '#ReconstrucciónLanús' ),

                  _.form(),

                  Labels( 
                    ruta: 'register',
                    titulo: 'Debes estar autorizado para ingresar',
                    subTitulo: 'Atención!',
                  ),

                  Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)

                ],
              ),
            ),
          ),
        ),
      )
   );
  }
}




