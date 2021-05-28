import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
final escuela = box.read('escuela');
final circuito = box.read('circuito');
final mesa = box.read('mesa');
CollectionReference users = FirebaseFirestore.instance.collection('data/$circuito/$escuela');

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

Future<void> addData( String nombre, int votos) {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            
           'mesa' : mesa,
           'nombre': nombre, // John Doe
           // 'company': company, // Stokes and Sons
            'votos': votos // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }