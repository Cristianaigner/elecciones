import 'package:elecciones/controllers/carga_controller.dart';
import 'package:elecciones/utils/update.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CargaPage extends StatelessWidget {
  final controller = Get.put(CargaController());
  final box = GetStorage();
  final textController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final escuela = box.read('escuela');
    final circuito = box.read('circuito');
    return GetBuilder<CargaController>(
        init: controller,
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('$escuela -- $circuito'),
              ),
              body: Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                child: Card(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      
                      SizedBox(height: 20),
                      _.crearItem(
                          'assets/Fdt.png', 'Agustin Balladares', 'Lista 259'),
                      _.crearItem(
                          'assets/Fdt.png', 'Nicolas Russo', 'Lista 260'),
                      _.crearItem(
                          'assets/tag-logo.png', 'Diego Kravetz', 'Lista 261'),
                      _.mostrarFoto(),
                      SizedBox(height: 20),
                      Center(
                          child: Column(
                        children: [
                          IconButton(
                              color: Colors.amber[900],
                              iconSize: 60,
                              onPressed: () => _.tomarFoto(),
                              icon: Icon(Icons.camera_alt_rounded)),
                          Text('Sacar foto del acta(Obligatorio)')
                        ],
                      )),
                      ElevatedButton(
                          onPressed: () { 
                            //_.subirImagen();
                            if(_.votosA != null && _.votosN != null && _.votosK != null ){
                            addData('Agustin Balladares', _.votosA);
                            print(mesa);
                            
                            print(_.votosA);
                            addData('Nicolas Russo', _.votosN);
                            addData('Diego Kravetz', _.votosK);
                            Get.snackbar('Exito', 'Se cargo correctamente'
                                );
                            Future.delayed(
                             Duration(seconds: 2),
                              () {
                            Get.offAndToNamed('principal');
                            
                                },
                            );
                            }
                            else {
                                Get.snackbar('Fallo', 'No puede haber campos vacios',
                                snackPosition: SnackPosition.BOTTOM);
                              }
                            
                            },
                          child: Text('Enviar'))
                    ],
                  ),
                ),
              ),
            ));
  }
}
