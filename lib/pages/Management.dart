import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/auth.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';
import 'package:pujapurohitmanagement/components/services/database.dart';
import 'package:pujapurohitmanagement/pages/manage/add_puja.dart';
import 'package:pujapurohitmanagement/pages/manage/panchang.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_page.dart';
import 'overview.dart';
import '../pages/manage/horoscope.dart';
import '../pages/manage/date.dart';

class Management extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool? admin;
    bool? superadmin;
    var screenSize = MediaQuery.of(context).size;
    final user = Provider.of<Users>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Admin')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.data()!['role'] == 'admin') {
            admin = true;
          } else {
            admin = false;
          }
          if (snapshot.data!.data()!['role'] == 'superadmin') {
            superadmin = true;
          } else {
            superadmin = false;
          }
          int efficiency = snapshot.data!.data()!['efficiency'];
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ResponsiveWidget.isSmallScreen(context)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AutoSizeText(
                                'Manage System !',
                                maxFontSize: 24,
                                minFontSize: 22,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907'),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        cl1: Color(0xFF56ab2f),
                                        cl2: Color(0xffa8e063),
                                        txt: 'Date',
                                        content: 'Update',
                                        icn: Icons.calendar_today_outlined,
                                        press: () {
                                          Get.toNamed('/date');
                                        }),
                                    Box(
                                      height: height * 0.15,
                                      width: width * 0.3,
                                      cl1: Color(0xff4568dc),
                                      cl2: Color(0xffb06ab3),
                                      txt: 'Horoscope',
                                      content: 'Update',
                                      icn: Icons.system_update_alt,
                                      press: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => D4(
                                                      database: database,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        cl1: Color(0xFF26D0CE),
                                        cl2: Colors.blueAccent,
                                        txt: 'Notification',
                                        content: 'Push',
                                        icn: Icons.notifications_active),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        cl1: Colors.tealAccent,
                                        cl2: Colors.teal[400]!,
                                        txt: 'Puja',
                                        content: 'Add',
                                        icn: Icons.store),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        cl1: Color(0xFFFF512F),
                                        cl2: Color(0xFFDD2476),
                                        txt: 'Pandit',
                                        content: 'Approve',
                                        icn: Icons.verified_outlined),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        cl1: Colors.orangeAccent,
                                        cl2: Colors.orange,
                                        txt: 'Astrologer',
                                        content: 'Approve',
                                        icn: Icons.verified_user_outlined)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                'Welcome ${snapshot.data!.data()!['name']} !',
                                maxFontSize: 24,
                                minFontSize: 22,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                width: screenSize.width * 0.1,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        cl1: Color(0xFF56ab2f),
                                        cl2: Color(0xffa8e063),
                                        txt: 'Date',
                                        content: 'Update',
                                        icn: Icons.today,
                                        press: () {
                                          Get.toNamed('/date');
                                        }),
                                    Box(
                                      height: height * 0.15,
                                      width: width * 0.2,
                                      cl1: Color(0xff4568dc),
                                      cl2: Color(0xffb06ab3),
                                      txt: 'Horoscope',
                                      content: 'Update',
                                      icn: Icons.system_update_alt,
                                      press: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => D4(
                                                      database: database,
                                                    )));
                                      },
                                    ),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        cl1: Color(0xFF26D0CE),
                                        cl2: Colors.blueAccent,
                                        txt: 'Notification',
                                        content: 'Push',
                                        icn: Icons.notifications_active),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        cl1: Colors.tealAccent,
                                        cl2: Colors.teal[400]!,
                                        txt: 'Puja',
                                        content: 'Add',
                                        icn: Icons.store),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        cl1: Color(0xFFFF512F),
                                        cl2: Color(0xFFDD2476),
                                        txt: 'Pandit',
                                        content: 'Approve ',
                                        icn: Icons.verified_user_outlined),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        cl1: Colors.orangeAccent,
                                        cl2: Colors.orange,
                                        txt: 'Astrologer',
                                        content: 'Approve',
                                        icn: Icons.verified_outlined),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        press: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PanchangPage()));
                                        },
                                        cl1: Colors.tealAccent,
                                        cl2: Colors.teal[400]!,
                                        txt: 'Panchang',
                                        content: 'Update',
                                        icn: Icons.calendar_today),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        press: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SamagriPage()));
                                        },
                                        cl1: Colors.tealAccent,
                                        cl2: Colors.teal[400]!,
                                        txt: 'Samagri',
                                        content: 'Update',
                                        icn: Icons.calendar_today),
                                    Box(
                                        height: height * 0.15,
                                        width: width * 0.2,
                                        press: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddAndEditPuja()));
                                        },
                                        cl1: Colors.tealAccent,
                                        cl2: Colors.yellow,
                                        txt: 'Add And Edit Puja',
                                        content: 'Puja List',
                                        icn: Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  Container Session(String txt, Color clrs) {
    return Container(
      width: 100,
      height: 30,
      child: Center(
          child: AutoSizeText(
        '$txt',
        style: GoogleFonts.aBeeZee(color: Colors.white),
        minFontSize: 12,
        maxFontSize: 12,
      )),
      decoration:
          BoxDecoration(color: clrs, borderRadius: BorderRadius.circular(10)),
    );
  }
}
