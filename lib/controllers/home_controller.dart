


import 'package:elecciones/utils/lista_escuela.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  String circuitoSel;
  String escuelaSel ;

  Widget crearCircuito() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButton(
          //dropdownColor: Colors.grey,

          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          isExpanded: true,
          icon: Icon(Icons.format_list_numbered),
          iconEnabledColor: Colors.blueAccent,
          value: circuitoSel,
          hint: Text('Seleccione circuito'),
          items: [
            DropdownMenuItem<String>(
                child: Center(child: Text('259')), value: "259"),
            DropdownMenuItem<String>(
                child: Center(child: Text('260')), value: "260"),
            DropdownMenuItem<String>(
                child: Center(child: Text('261')), value: "261"),
            DropdownMenuItem<String>(
                child: Center(child: Text('262')), value: "262"),
            DropdownMenuItem<String>(
                child: Center(child: Text('263')), value: "263"),
            DropdownMenuItem<String>(
                child: Center(child: Text('264')), value: "264"),
            DropdownMenuItem<String>(
                child: Center(child: Text('265')), value: "265"),
            DropdownMenuItem<String>(
                child: Center(child: Text('271')), value: "271"),
            DropdownMenuItem<String>(
                child: Center(child: Text('272')), value: "272"),
            DropdownMenuItem<String>(
                child: Center(child: Text('273')), value: "273"),
            DropdownMenuItem<String>(
                child: Center(child: Text('274')), value: "274"),
            DropdownMenuItem<String>(
                child: Center(child: Text('275')), value: "275"),
            DropdownMenuItem<String>(
                child: Center(child: Text('276')), value: "276"),
          ],
          onChanged: (cir) {
            circuitoSel = cir;
            
            update();
          }),
    );
  }
  Widget crearEscuela() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButton(
          //dropdownColor: Colors.grey,

          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          isExpanded: true,
          icon: Icon(Icons.format_list_numbered),
          iconEnabledColor: Colors.blueAccent,
          value: escuelaSel,
          hint: Text('Seleccione escuela'),
          

          items:getOpcionesDrop(),
          
           
          onChanged: (cir) {
            
            escuelaSel = cir;
            update(['escuela']);
          }),
    );
  }
List<DropdownMenuItem<String>> getOpcionesDrop() {
    List<DropdownMenuItem<String>> lista = [];
  
  switch (circuitoSel) {
    case '259':
      lista = [];  
         lista269.forEach((act) {
         lista.add(DropdownMenuItem(
         child: Text(act),
         value: act,
       ));
       });
      break;
    case '260':
      lista = [];  
         lista260.forEach((act) {
         lista.add(DropdownMenuItem(
         child: Text(act),
         value: act,
       ));
       });
      break;
    case '261':
      lista = [];  
         lista261.forEach((act) {
         lista.add(DropdownMenuItem(
         child: Text(act),
         value: act,
       ));
       });
      break;
    
    default: Text('Seleccione Escuela');
  }
      return lista;
  }


}