import 'package:flutter/cupertino.dart';
import 'package:pujapurohitmanagement/components/roles.dart';

class AdminModal {
  final String? image;
  final String? name;
  final String? role;
  final String? uid;
  AdminModal({this.image, this.name, this.role, this.uid,});
  factory AdminModal.fromMap(Map<String , dynamic>data){

    final String? image=data['image'];
    final String? name=data['name'];
    final String? role=data['role'];
    final String? uid=data['uid'];
    return AdminModal(
     image: image,
      name: name,
      role: role,
      uid: uid
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'image':image,
        'nname':name,
        'role':role,
        'uid':uid
      };
  }
}