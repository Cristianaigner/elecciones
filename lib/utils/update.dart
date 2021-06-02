import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
final escuela = box.read('escuela');
final circuito = box.read('circuito');

CollectionReference users =
    FirebaseFirestore.instance.collection('votos/$circuito/$escuela');
CollectionReference imagenes =
    FirebaseFirestore.instance.collection('imagen/$circuito/$escuela');

Future<void> updateUser(String id) {
  return users
      .doc(id)
      .update({'edad': 25})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> deleteUser(String id) {
  return users
      .doc(id)
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}

Future<void> addData(String nombre, int votos) {
  var mesa = box.read('mesa');
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'mesa': mesa,
        'nombre': nombre, // John Doe
        // 'company': company, // Stokes and Sons
        'votos': votos, // 42
        // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> addFoto(String url) {
  var mesa = box.read('mesa');
  print('Mi mesa: $mesa');
  // Call the user's CollectionReference to add a new user
  return imagenes
      .add({
        'mesa': mesa,
        'Url': url, // John Doe
        // 'company': company, // Stokes and Sons
        // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
