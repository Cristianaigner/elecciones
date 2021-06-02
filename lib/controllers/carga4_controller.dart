import 'dart:convert';
import 'dart:io';

import 'package:elecciones/utils/update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Carga4Controller extends GetxController {
  int votosA;
  int votosN;
  int votosK;
  File imageFile;
  final picker = ImagePicker();
  var urlFoto;

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

  void salvar() {
    addFoto(urlFoto).then((value) {
      addData('Agustin Balladares', votosA);
      addData('Nicolas Russo', votosN);
      addData('Diego Kravetz', votosK);
    });
  }

  mostrarFoto() {
    if (imageFile == null) {
      return Image(
          height: 150,
          width: 100,
          fit: BoxFit.cover,
          image: AssetImage('assets/no-image.png'));
    } else {
      return Image.file(imageFile, height: 200, width: 100, fit: BoxFit.cover);
    }
  }

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
    urlFoto = respData['url'];
    print('respuesta mia: ${respData['url']}');
    addFoto(urlFoto).then((value) {
      addData('Agustin Balladares', votosA);
      addData('Nicolas Russo', votosN);
      addData('Diego Kravetz', votosK);
    });
    return respData['secure_url'];
  }

  botonFoto() {
    return Center(
        child: Column(
      children: [
        IconButton(
            color: Colors.amber[900],
            iconSize: 60,
            onPressed: () => tomarFoto(),
            icon: Icon(Icons.camera_alt_rounded)),
        Text('Sacar foto del acta(Obligatorio)')
      ],
    ));
  }
}
