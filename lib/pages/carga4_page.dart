import 'package:elecciones/controllers/carga4_controller.dart';
//import 'package:elecciones/utils/update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Carga4Page extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Carga4Controller());

    return Scaffold(
      body: GetBuilder<Carga4Controller>(
          init: controller,
          builder: (_) => Container(
                padding: EdgeInsets.only(top: 100),
                child: ListView(children: [
                  Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        _.crearAgus(),
                        SizedBox(height: 10),
                        _.crearNicola(),
                        SizedBox(height: 10),
                        _.crearKravetz(),
                        SizedBox(height: 20),
                        _.mostrarFoto(),
                        SizedBox(height: 20),
                        _.botonFoto(),
                        SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              if (!_keyForm.currentState.validate())
                                return; // pone asi para evitar el else
                              if (_.imageFile == null) {
                                Get.dialog(AlertDialog(
                                  title: Text('Atencion'),
                                  content: Text(
                                      'Es obligatorio subir la foto del acta'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text('ok'))
                                  ],
                                ));
                                return;
                              }
                              _keyForm.currentState
                                  .save(); // esto es para disparar todos los onSave del formulario
                              _.subirImagen();
                              //_.salvar();
                              _.imageFile = null;
                              Get.snackbar('Exito', 'Se cargo correctamente');
                              Future.delayed(
                                Duration(seconds: 2),
                                () {
                                  Get.offAndToNamed('principal');
                                },
                              );
                            },
                            child: Text('ok'))
                      ],
                    ),
                  ),
                ]),
              )),
    );
  }
}
