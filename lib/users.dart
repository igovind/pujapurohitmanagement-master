import 'package:cloud_firestore/cloud_firestore.dart';

class NewUser{
  var iid;
  var name;
  var image;
  var role;
  NewUser({this.role,this.iid,this.image,this.name});
  
  NewUser.fromDocumenetSnapshot({DocumentSnapshot? documentSnapshot}){
    iid = documentSnapshot!.id;
    name = documentSnapshot['name'];
    role = documentSnapshot['role'];
    image = documentSnapshot['image'];
  }
}