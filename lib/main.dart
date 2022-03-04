import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/extra_folder/all_prohit_profiles.dart';
import 'package:pujapurohitmanagement/extra_folder/db_management.dart';
import 'package:pujapurohitmanagement/extra_folder/purohit_services_promlem_resolve.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/purohit_basic_details_form.dart';
import 'package:pujapurohitmanagement/extra_folder/pandit_users_transfer.dart';
import 'package:pujapurohitmanagement/extra_folder/puja_ceremony_transfer.dart';
import 'package:pujapurohitmanagement/pages/MainPage.dart';
import 'package:pujapurohitmanagement/pages/Temporay.dart';
import 'package:pujapurohitmanagement/pages/dashboard/PanditDetail.dart';
import 'package:pujapurohitmanagement/pages/dashboard/sales.dart';
import 'package:pujapurohitmanagement/pages/dashboard/users.dart';
import 'package:pujapurohitmanagement/pages/login.dart';
import 'package:pujapurohitmanagement/pages/manage/notice_board/notice_board_page.dart';
import 'package:pujapurohitmanagement/pages/manage/panchang.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/add_new_puja.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/master.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/testing.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_page.dart';
import 'package:pujapurohitmanagement/pages/sales/Request.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/purohit_profile_landing_page.dart';
import 'components/auth.dart';
import 'components/services/database.dart';
import 'extra_folder/purohit_puja_transfer.dart';
import 'pages/manage/date.dart';

void main() async {
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: GetMaterialApp(
        title: 'Admin Puja Purohit',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        //home: Controller(),
        //initialRoute: '/root',
        home: Controller(),
        theme: ThemeData(primaryColor: LightColors.kDarkYellow),
        defaultTransition: Transition.zoom,
        getPages: [
          GetPage(name: '/home', page: () => Controller()),
          GetPage(name: '/users', page: () => AvailableUsers()),
          GetPage(name: '/pandits', page: () => AvailableUsers()),
          GetPage(name: '/sales', page: () => Sales()),
          GetPage(name: '/request', page: () => Request()),
          GetPage(name: '/pandit_detail', page: () => UserDetail()),
          GetPage(name: '/date', page: () => D3())
        ],
      ),
    );
  }
}

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<Users?>(
      stream: auth.onAuthChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          Users? user = snapshot.data;
          if (user == null) {
            return Provider<Users?>.value(
                value: user,
                child: Provider<Database>(
                  create: (_) => FirestoreDatabase(uid: user!.uid),
                  child: LoginPage(),
                ));
          } else {
            return Provider<Users>.value(
                value: user,
                child: Provider<Database>(
                  create: (_) => FirestoreDatabase(uid: user.uid),
                  //child: Testing(),
                  //child:AddAndEditPuja()//PujaForm()//SamagriPage()//SamagriForm()//
                  /*child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .doc("inventories/listed_puja")
                          .snapshots(),
                      builder: (context, snapshotS) {
                        if (snapshotS.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List<dynamic> list =
                            snapshotS.data!.get("listed_puja");
                        final List<dynamic> lists =
                            snapshotS.data!.get("listed_samagri");
                        list.sort((a, b) => (b["pjid"]).compareTo(a["pjid"]));
                        lists.sort((a, b) => (b["sid"]).compareTo(a["sid"]));
                        return Master(
                          samList: lists,
                          listofPuja: list,
                        );
                      }),*/
                  // child: SamagriPage(),
                  //--> child: MainPage(uid:user.uid,users:user)
                  //Dashboard(admin:user.uid,),
                  child:AllProhit(),
                  //child: PurohitPujaTransfer(),
                  /*PanditProfileList(
                    panditDisplayProfile:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH-IThiMFnYhmcGPJjUlCyDP-M2HUeW5mIwQ&usqp=CAU",
                    panditName: "Pt. Aditya Nath",
                    panditAge: "56",
                    panditMobileNumber: "9899721479",
                    panditState: "Delhi",
                    panditCity: "Budh Vihar",
                    panditExperience: "8",
                    panditCoverProfile: "https://cdn.wionews.com/sites/default/files/styles/photo_page/public/2018/09/12/29808-000_sr8ux-20170929080030.jpg",
                    panditQualification:
                        "Bachelor’s Degree and General B.Ed degree with a two-year Diploma in Special Education recognised by the Rehabilitation Council of India (RCI). (or)",
                    panditBio:
                        "Yogi Adityanath is an Indian Hindu monk and politician serving as the 22nd and current Chief Minister of Uttar Pradesh, in office since 19 March 2017. ",
                  ),*/
                ));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class GetxC extends GetWidget<FirebaseController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<FirebaseController>().user != null ? Temp() : LoginPage();
    });
  }
}
