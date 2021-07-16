
import 'package:get/get.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';

class InstanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FirebaseController>(() => FirebaseController());
  }

}