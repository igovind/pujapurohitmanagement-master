
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/bindings/instance.dart';
import 'package:pujapurohitmanagement/pages/MainPage.dart';
import 'package:pujapurohitmanagement/pages/Temporay.dart';
import 'package:pujapurohitmanagement/pages/dashboard/PanditDetail.dart';
import 'package:pujapurohitmanagement/pages/dashboard/sales.dart';
import 'package:pujapurohitmanagement/pages/dashboard/users.dart';
import 'package:pujapurohitmanagement/pages/login.dart';
import 'package:pujapurohitmanagement/pages/manage/add_puja.dart';
import 'package:pujapurohitmanagement/pages/manage/puja_form.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_form.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_page.dart';
import 'package:pujapurohitmanagement/pages/sales/Request.dart';
import 'package:pujapurohitmanagement/root.dart';

import 'components/auth.dart';
import 'components/services/database.dart';
import 'pages/manage/date.dart';
import 'root.dart';
import 'root.dart';

void main() async{
  //await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(create: (context)=>Auth(),
    child: GetMaterialApp(
     
      title: 'Admin Puja Purohit',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      //home: Controller(),
      //initialRoute: '/root',
      home: Controller(),
      theme: ThemeData(
          primaryColor: LightColors.kDarkYellow),
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(name: '/home', page:()=>Controller()),
        GetPage(name: '/users', page: ()=>AvailableUsers()),
        GetPage(name: '/pandits', page: ()=>AvailableUsers()),
        GetPage(name: '/sales', page:()=>Sales()),
        GetPage(name: '/request', page:()=> Request()),
        GetPage(name: '/pandit_detail', page: ()=>UserDetail()),
        GetPage(name: '/date', page: ()=>D3())
      ],   
    ),
    );
  }
  
}
class Controller extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<Users?>(
      stream: auth.onAuthChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          Users? user=snapshot.data;
          if(user==null){
            return Provider<Users?>.value(
                value: user,
                child: Provider<Database>(
                  create: (_)=>FirestoreDatabase(uid: user!.uid),
                  child: LoginPage(),
                )
            );
          }

          else{
            return Provider<Users>.value(
                value: user,
                child: Provider<Database>(
                    create: (_)=>FirestoreDatabase(uid: user.uid),
                    //child:AddAndEditPuja()//PujaForm()//SamagriPage()//SamagriForm()//
                  child: MainPage(uid:user.uid,users:user)
                  //Dashboard(admin:user.uid,),
                )
            );}
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

}
class GetxC extends GetWidget<FirebaseController>{
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Get.find<FirebaseController>().user!=null ? Temp():LoginPage();
    });
  }

}