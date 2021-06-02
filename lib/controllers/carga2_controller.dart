import 'dart:convert';

import 'dart:io';

import 'package:elecciones/utils/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Carga2Controller extends GetxController {
  //final user = UserController();
  final formKeyv = GlobalKey<FormState>();
  //var formKeyv = user.formKey;
  File imageFile;
  final picker = ImagePicker();
  int votosA;
  int votosN;
  int votosK;

  // mostrarFoto() {
  //  imageFile == null ? Text('No image selected.') : Image.file(imageFile);
  //}
  mostrarFoto() {
    if (imageFile == null) {
      return Image(
          height: 200,
          width: 100,
          fit: BoxFit.cover,
          image: AssetImage('assets/no-image.png'));
    } else {
      return Image.file(imageFile, height: 200, width: 100, fit: BoxFit.cover);
    }
  }
  //NetworkImage(
  //  'http://res.cloudinary.com/albafranz/image/upload/v1622141242/vk7aszyzxe0bcrvd62e3.jpg')
  // AssetImage(imageFile?.uri ?? 'assets/no-image.png'));
  //}

  // tomarFoto() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //   }
  //   update();
  // }
  tomarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  Future<String> subirImagen() async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/albafranz/image/upload?upload_preset=fd6zv9jz');
    final mimeType = mime(imageFile.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imageFile.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

  void submit() async {
    if (!formKeyv.currentState.validate())
      return; // pone asi para evitar el else

    formKeyv.currentState.save();
    addData('Agustin Balladares', votosA);
    addData('Nicolas Russo', votosN);
    addData('Diego Kravetz', votosK);
    Get.snackbar('Exito', 'Se cargo correctamente');
    formKeyv.currentState.reset();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Get.offAndToNamed('principal');
      },
    ); // esto es para disparar todos los onSave del formulario
  }

  Widget crearAgus() {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          //foregroundImage: AssetImage(),
          backgroundImage: AssetImage('assets/Fdt.png'),
        ),
        title: Text('Agustin Balladares'),
        subtitle: Text('Lista 260'),
        trailing: SizedBox(
          width: 50,
          child: TextFormField(
              //initialValue: opcSelec,
              keyboardType: TextInputType.number,
              onSaved: (value) => votosA = int.parse(value),
              validator: (value) {
                if (value.length < 1) {
                  return '[vacio]';
                } else {
                  return null;
                }
              }),
        ));
  }

  Widget crearNicola() {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          //foregroundImage: AssetImage(),
          backgroundImage: AssetImage('assets/Fdt.png'),
        ),
        title: Text('Nicolas Russo'),
        subtitle: Text('Lista 261'),
        trailing: SizedBox(
          width: 50,
          child: TextFormField(
              //initialValue: opcSelec,
              keyboardType: TextInputType.number,
              onSaved: (value) => votosN = int.parse(value),
              validator: (value) {
                if (value.length < 1) {
                  return '[vacio]';
                } else {
                  return null;
                }
              }),
        ));
  }

  Widget crearKravetz() {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          //foregroundImage: AssetImage(),
          backgroundImage: AssetImage('assets/Fdt.png'),
        ),
        title: Text('Diego Kravetz'),
        subtitle: Text('Lista 262'),
        trailing: SizedBox(
          width: 50,
          child: TextFormField(
              //initialValue: opcSelec,
              keyboardType: TextInputType.number,
              onSaved: (value) => votosK = int.parse(value),
              validator: (value) {
                if (value.length < 1) {
                  return '[vacio]';
                } else {
                  return null;
                }
              }),
        ));
  }

  Widget crearBoton() {
    return ElevatedButton.icon(
        // shape:
        //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        //color: Colors.blueAccent,
        //textColor: Colors.white,
        onPressed: submit, //no hace falta parentesis porque ya es un callback
        icon: Icon(Icons.save),
        label: Text('Enviar'));
  }
}
