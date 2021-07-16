import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PressedState extends GetxController{
  var pressedBool = false;
  changeStatus() {
    if(pressedBool){
      pressedBool = false;

    }
    else {
      pressedBool = true;
    }
    update();
  }

}