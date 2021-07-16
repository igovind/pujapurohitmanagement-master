
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pujapurohitmanagement/users.dart';

class DataService{
final FirebaseFirestore _firestore= FirebaseFirestore.instance;

Future<NewUser?> getUser(String uid) async{

  try{
    DocumentSnapshot doc =  await _firestore.collection('Admin').doc('$uid').get();
     return NewUser.fromDocumenetSnapshot(documentSnapshot:doc);
  }catch(e){
    Get.snackbar('Error', '${e.toString()}');
  }
}

}