import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'circuito',
        init: controller,
        builder: (_) {
          return Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    _.crearCircuito(),
                    SizedBox(
                      height: 20,
                    ),
                    GetBuilder<HomeController>(
                        id: 'escuela',
                        builder: (_) {
                          return _.crearEscuela();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        color: Colors.blueAccent,
                        child: Text('Guardar'),
                        elevation: 2,
                        onPressed: () => _.press())
                  ],
                )),
          );
        });
  }
}
