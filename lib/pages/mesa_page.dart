import 'package:elecciones/controllers/carga_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class MesaPage extends StatelessWidget {
  
final controller = Get.put(CargaController());

final box = GetStorage();

  
  @override
  Widget build(BuildContext context) {
    String mesa;
    return  Scaffold(
          body: ListView(
            padding: EdgeInsets.only(top:250),
          children: [ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: AssetImage('assets/mesa.png')),
                              title: Text('Numero de mesa'),

                              trailing: SizedBox(width: 50, child: 
                              TextField(
                                keyboardType: TextInputType.number ,
                                onChanged: (value) => 
                                mesa = value,
                              )),
                              //onTap: () => _.showAlert('Agustin Balladares'),
                            ),
                            SizedBox(height: 40),
            
                            ElevatedButton(
                            onPressed: () { 
                              if(mesa != null){
                              //_.subirImagen();
                              box.write('mesa', mesa);
                              print(box.read('mesa'));
                              Get.toNamed('carga');
                              }
                              else {
                                Get.snackbar('Fallo', 'No puede estar vacio',
                                snackPosition: SnackPosition.BOTTOM);
                              }
                              },
                            child: Text('Continuar'))
          ],
        
      ),
    );
  }
}