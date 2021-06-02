import 'package:elecciones/widgets/boton_azul.dart';
import 'package:elecciones/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final box = GetStorage();

  form() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passwordController,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Ingrese',
            onPressed: () async {
              print(emailController.text);
              print(passwordController.text);
              signInWithEmailAndPassword();
            },
          )
        ],
      ),
    );
  }

  // Example code of how to sign in with email and password.
  void signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      ))
          .user;
      box.write('login', true);
      Get.snackbar('Hola', 'Su ingreso ha sido exitoso');
      print('Ingreso bien');
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.toNamed("home");
        },
      );
    } catch (e) {
      Get.snackbar('Fallo', 'No puede ingresar, revise',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }

  void signOut() async {
    final User user = await _auth.currentUser;
    if (user == null) {
      Get.snackbar('Out', 'No one has signed in.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _signOut();
    final String uid = user.uid;
    Get.snackbar('Out', uid + ' has successfully signed out.',
        snackPosition: SnackPosition.BOTTOM);
    Get.offAndToNamed("/home");
  }
}
