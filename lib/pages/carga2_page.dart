import 'package:elecciones/controllers/carga2_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Carga2Page extends StatelessWidget {
  final controller = Get.put(Carga2Controller());
  final box = GetStorage();
  //final textController = TextEditingController();
  //var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final escuela = box.read('escuela');
    final circuito = box.read('circuito');
    return GetBuilder<Carga2Controller>(
      init: controller,
      //dispose: (state) => print('char'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('$escuela -- $circuito'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Form(
            key: _.formKeyv,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  _.crearAgus(),
                  SizedBox(height: 20.0),
                  _.crearNicola(),
                  SizedBox(height: 20.0),
                  _.crearKravetz(),
                  SizedBox(height: 20.0),
                  _.crearBoton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
