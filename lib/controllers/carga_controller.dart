import 'dart:convert';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CargaController extends GetxController {
  // final formKey = GlobalKey<FormState>();
  File imageFile;
  final picker = ImagePicker();
  int votosA;
  int votosN;
  int votosK;
  Widget crearItem(String imagen, String titulo, String subtitulo) {
    //votosA ;
    //votosN ;
    //votosK ;
    return Form(
      //key: formKey,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          foregroundImage: AssetImage(imagen),
          //backgroundImage: AssetImage('assets/Fdt.png'),
        ),
        title: Text(titulo),
        subtitle: Text(subtitulo),
        trailing: SizedBox(
            width: 50,
            child: TextFormField(validator: (value) {
              if (value.length == 0) {
                return 'Ingrese un numero valido';
              } else {
                return null;
              }
            }, onChanged: (value) {
              if (titulo.contains('Agustin')) {
                votosA = int.parse(value);
              } else if (titulo.contains('Nicolas')) {
                votosN = int.parse(value);
              } else {
                votosK = int.parse(value);
              }
            })),
      ),
    );
  }

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
}
