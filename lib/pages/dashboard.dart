import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/auth.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';
import 'package:pujapurohitmanagement/pages/dashboard/sales.dart';

import 'overview.dart';


class Dashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool? admin;
    bool? superadmin;
    var screenSize = MediaQuery.of(context).size;
    final user=Provider.of<Users>(context,listen: false);
    final auth = Provider.of<AuthBase>(context,listen: false);
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Admin').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.data==null){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data!.data()!['role'] == 'admin'){
            admin=true;
          }
          else{
            admin=false;
          }
          if(snapshot.data!.data()!['role'] == 'superadmin'){
            superadmin=true;
          }
          else{
            superadmin=false;
          }
          int efficiency= snapshot.data!.data()!['efficiency'];
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ResponsiveWidget.isSmallScreen(context)?
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AutoSizeText('Dashboard !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907'),)
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    SizedBox(height: screenSize.height*0.05,),
                    Row(

                      children: [
                        superadmin!?Session('Stocks: 50%',Colors.green,context):SizedBox(),
                        superadmin!?SizedBox(width: 10,):SizedBox(),
                        superadmin!?Expanded(child: Session('Loss Sck: ${snapshot.data!.data()!['session']}',Colors.redAccent,context),):SizedBox(),
                        SizedBox(width: 10,),
                        Expanded(child: Session('Time : ${DateFormat.jm().format(DateTime.now())}',Colors.lightBlueAccent,context),),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              auth.signOut();
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              child: Center(child: AutoSizeText('Log Out',style: TextStyle(color: Colors.white),minFontSize: 12,maxFontSize: 12,)),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                        ),
                      ],),
                    SizedBox(height: screenSize.height*0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        superadmin!?Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Sales', content: 'Overview', icn: FontAwesomeIcons.moneyBill,press: (){
                               Get.toNamed('/sales?user=${user.uid}&superadmin=$superadmin&admin=$admin');
                              }),
                              Box(height: height*0.15, width: width*0.3, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Refund', content: 'Active: 2', icn:FontAwesomeIcons.solidWindowClose),

                            ],
                          ),
                        ):admin!?
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Sales', content: 'Overview', icn: FontAwesomeIcons.moneyBill,press: (){
                                Get.toNamed('/sales?user=${user.uid}&superadmin=$superadmin&admin=$admin');
                              }),
                              Box(height: height*0.15, width: width*0.3, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'CashBack', content: 'Total: 50', icn:Icons.card_giftcard_outlined),
                            ],
                          ),
                        ):SizedBox(),

                        //___________________-- Users Pandits_________________
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data == null){
                                    return Center(child:CircularProgressIndicator());
                                  }
                                  bool use = true;
                                  return Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: 'Users', content: '${snapshot.data!.docs.length}', icn:Icons.supervised_user_circle_outlined,
                                      press: (){
                                            Get.toNamed('/users?superadmin=$superadmin&type=$use');
                                  });
                                }
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('Avaliable_pundit').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data == null){
                                    return Center(child:CircularProgressIndicator());
                                  }
                                  bool use = false;
                                  return Box(height: height*0.15, width: width*0.3, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: 'Pandit', content: '${snapshot.data!.docs.length}', icn:Icons.account_circle_outlined,press: (){
                                    Get.toNamed('/pandits?superadmin=$superadmin&type=$use');
                                  });
                                }
                              ),

                            ],
                          ),
                        ),
                        //___________________Puja Atrologer_________________
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Avaliable_pundit').where('astrologer', isEqualTo: true).snapshots(),
                                builder: (context, asnapshot) {
                                    if(asnapshot.data==null){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    bool useee = false;
                                    bool astro = true;
                                  return Box(height: height*0.15, width: width*0.3, cl1: Color(0xff667eea), cl2: Color(0xff764ba2), txt:"Astrologer's", content: '${asnapshot.data!.size}', icn: FontAwesomeIcons.userAstronaut,
                                  press: (){ Get.toNamed('/pandits?superadmin=$superadmin&type=$useee&astro=$astro'); },
                                  );
                                }
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Category').snapshots(),
                                builder: (context, psnapshot) {
                                  if(psnapshot.data==null){
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                  return Box(height: height*0.15, width: width*0.3, cl1: Color(0xff1e3c72), cl2: Color(0xff2a5298), txt:"Available Puja", content: '${psnapshot.data!.size}', icn:FontAwesomeIcons.om );
                                }
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Box(height: height*0.15, width: width*0.3, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Recharge', content: 'Most', icn: Icons.shop),
                              Box(height: height*0.15, width: width*0.3, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: "Complains's", content: 'Active: 10', icn:FontAwesomeIcons.exclamationCircle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ):
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      children: [
                        AutoSizeText('Dashboard !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
                        SizedBox(width: screenSize.width*0.1,),
                        superadmin!?Session('Stocks: 50%',Colors.green,context):SizedBox(),
                        superadmin!?SizedBox(width: 10,):SizedBox(),
                        superadmin!?Expanded(child: Session('Loss Sck: ${snapshot.data!.data()!['session']}',Colors.redAccent,context),):SizedBox(),
                        SizedBox(width: 10,),
                        Expanded(child: Session('Time : ${DateFormat.jm().format(DateTime.now())}',Colors.lightBlueAccent,context),),
                        SizedBox(width: 10,),
                        Expanded(child: InkWell(
                          onTap: (){
                            auth.signOut();
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            child: Center(child: AutoSizeText('Log Out',style: TextStyle(color: Colors.white),minFontSize: 12,maxFontSize: 12,)),
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),),
                        SizedBox(width: screenSize.width*0.055,),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907'),)
                      ],
                    ),
                    SizedBox(height: screenSize.height*0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        superadmin!?Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt:'Sales', content: 'Overview', icn: FontAwesomeIcons.moneyBill,press: (){Get.toNamed('/sales?user=${user.uid}&superadmin=$superadmin&admin=$admin');},),
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Refund', content: 'Active: 2', icn:FontAwesomeIcons.solidWindowClose),
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xff0099f7), cl2: Color(0xfff11712), txt: 'CashBack', content: 'Total: 50', icn:FontAwesomeIcons.gift),
                            ],
                          ),
                        ):admin!?Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt:'Sales', content: 'Overview', icn: FontAwesomeIcons.moneyBill,press: (){Get.toNamed('/sales?user=${user.uid}&superadmin=$superadmin&admin=$admin');},),
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Refund', content: 'Active: 2', icn:FontAwesomeIcons.solidWindowClose),
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xff0099f7), cl2: Color(0xfff11712), txt: 'CashBack', content: 'Total: 50', icn:FontAwesomeIcons.gift),
                            ],
                          ),
                        ):SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data == null){
                                    return Center(child:CircularProgressIndicator());
                                  }
                                  bool use=true;
                                  return Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: "User's", content: '${snapshot.data!.size}', icn:Icons.supervised_user_circle_outlined,press: (){
                                    Get.toNamed('/users?superadmin=$superadmin&type=$use');
                                  });
                                }
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Avaliable_pundit').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data == null){
                                    return Center(child:CircularProgressIndicator());
                                  }
                                  final bool use=false;
                                  return Box(height: height*0.15, width: width*0.2, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: "Pandit's", content: '${snapshot.data!.size}', icn:Icons.account_circle_outlined,press:(){
                                    Get.toNamed('/pandits?superadmin=$superadmin&type=$use');
                                    });
                                }
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Avaliable_pundit').where('astrologer', isEqualTo: true).snapshots(),
                                  builder: (context, asnapshot) {
                                    if(asnapshot.data==null){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    bool useee = false;
                                    bool astro = true;
                                    return Box(height: height*0.15, width: width*0.2, cl1: Color(0xff667eea), cl2: Color(0xff764ba2), txt:"Astrologer's", content: '${asnapshot.data!.size}', icn: FontAwesomeIcons.userAstronaut,
                                      press: (){ Get.toNamed('/pandits?superadmin=$superadmin&type=$useee&astro=$astro'); },
                                    );
                                  }
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:30,left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //SizedBox(width: 10,),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Category').snapshots(),
                                  builder: (context, psnapshot) {
                                    if(psnapshot.data==null){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return Box(height: height*0.15, width: width*0.2, cl1: Color(0xff1e3c72), cl2: Color(0xff2a5298), txt:"Available Puja", content: '${psnapshot.data!.size}', icn:FontAwesomeIcons.om );
                                  }
                              ),
                              Box(height: height*0.15, width: width*0.2, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Recharge', content: 'Most', icn: Icons.shop),
                              Box(height: height*0.15, width: width*0.2, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: "Complains's", content: 'Active: 10', icn:FontAwesomeIcons.exclamationCircle),
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
        }
    );
  }
  Container Session(String txt,Color clrs,BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      child: Center(child: AutoSizeText('$txt',style: GoogleFonts.aBeeZee(color: Colors.white),minFontSize: ResponsiveWidget.isSmallScreen(context)?8:10,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11,)),
      decoration: BoxDecoration(
          color: clrs,
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}