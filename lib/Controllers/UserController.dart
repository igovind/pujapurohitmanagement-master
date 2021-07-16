
import 'package:get/get.dart';
import 'package:pujapurohitmanagement/users.dart';

class UserController extends GetxController{
  Rx<NewUser> newuser = NewUser().obs;

  NewUser get user => newuser.value;

  set user(NewUser value) => this.newuser.value = value;

  void clear(){
    newuser.value = NewUser();
  }
}