import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohitmanagement/Controllers/UserController.dart';
import 'package:pujapurohitmanagement/users.dart';

import '../Controllers/FirebaseController.dart';

class Temp extends GetWidget<FirebaseController>{
  @override
  Widget build(BuildContext context) {
   FirebaseController firebaseController = FirebaseController();
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${controller.user!.uid}'),
          TextButton(child: Text('SignOut'),onPressed: (){
              controller.signOut();
          },),
        ],
      ),
    );
  }

}