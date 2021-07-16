
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';
import 'package:pujapurohitmanagement/Controllers/UserController.dart';
import 'package:pujapurohitmanagement/pages/Temporay.dart';
import 'package:pujapurohitmanagement/pages/login.dart';

import 'pages/Temporay.dart';
import 'pages/login.dart';
import 'pages/login.dart';

class Root extends GetWidget<FirebaseController>{
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<FirebaseController>().user?.uid != null) {
          return Temp();
        } else {
          return LoginPage();
        }
      },
    );
  }

}