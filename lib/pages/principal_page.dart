import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
                child: Text('Cargar datos'),
                height: 60,
                minWidth: 200,
                elevation: 5,
                color: Colors.blueAccent,
                onPressed: () => Get.toNamed('mesa')),
            SizedBox(height: 50),
            MaterialButton(
                child: Text('Alertas'),
                color: Colors.red,
                height: 60,
                elevation: 5,
                minWidth: 200,
                onPressed: () => Get.toNamed('alerta'))
          ],
        ),
      ),
    );
  }
}
