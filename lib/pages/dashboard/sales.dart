import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/auth.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';

import '../overview.dart';

class Sales extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   String  uid = Get.parameters['user']!;

   var screenSize = MediaQuery.of(context).size;
   double height=MediaQuery.of(context).size.height;
   double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: ResponsiveWidget.isSmallScreen(context)?
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AutoSizeText('Sales !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
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
                  Session('Updating Live',Colors.green,context),
                  Get.parameters['superadmin']!=null?SizedBox(width: 10,):SizedBox(),
                  Get.parameters['superadmin']!=null?Expanded(child: Session('Loss Sck:',Colors.redAccent,context),):SizedBox(),
                  SizedBox(width: 10,),
                  Expanded(child: Session('Time : ${DateFormat.jm().format(DateTime.now())}',Colors.lightBlueAccent,context),),
                  SizedBox(width: 10,),
                ],),
              SizedBox(height: screenSize.height*0.02,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Analytics', content: 'Revenue', icn: FontAwesomeIcons.moneyBill,press: (){

                        }),
                        Box(height: height*0.15, width: width*0.3, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Analytics', content: 'Refund', icn:FontAwesomeIcons.solidWindowClose),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream:FirebaseFirestore.instance.collection('RBOOKING').snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.data==null){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            bool book=false;
                            return Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: 'Requests', content: '${snapshot.data!.size}', icn:FontAwesomeIcons.appleAlt,
                            press: (){
                              Get.toNamed('/request?booking=$book');
                            });
                          }
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('Bookings').snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.data==null){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            bool book=true;
                            return Box(height: height*0.15, width: width*0.3, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: 'Booked', content: '${snapshot.data!.size}', icn:FontAwesomeIcons.firstOrder,press: (){
                              Get.toNamed('/request?booking=$book');
                            });
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
                        Box(height: height*0.15, width: width*0.3, cl1: Color(0xff667eea), cl2: Color(0xff764ba2), txt:'Analytics', content: 'Request', icn: FontAwesomeIcons.chartPie),
                        Box(height: height*0.15, width: width*0.3, cl1: Color(0xff1e3c72), cl2: Color(0xff2a5298), txt:'Analytics', content: 'Booking', icn: Icons.show_chart)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('RBOOKING').where('cancel', isEqualTo: true).snapshots(),
                          builder: (context, requestsnapshot) {
                            if(requestsnapshot.data == null){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('Bookings').where('cancel', isEqualTo: true).snapshots(),
                              builder: (context, bookingsnapshot) {
                                if(bookingsnapshot.data == null){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                return Box(height: height*0.15, width: width*0.3, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Cancelled', content: '${requestsnapshot.data!.size+bookingsnapshot.data!.size}', icn: Icons.assistant_photo_outlined);
                              }
                            );
                          }
                        ),
                        Box(height: height*0.15, width: width*0.3, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: "Analytic's", content: 'Cancel', icn:FontAwesomeIcons.exclamationCircle),
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
                  AutoSizeText('Sales !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
                  SizedBox(width: screenSize.width*0.1,),
                  Session('Updating Live',Colors.green,context),
                  Get.parameters['superadmin']!=null?SizedBox(width: 10,):SizedBox(),
                  Get.parameters['superadmin']!=null?Expanded(child: Session('Loss Sck: ',Colors.redAccent,context),):SizedBox(),
                  SizedBox(width: 10,),
                  Expanded(child: Session('Time : ${DateFormat.jm().format(DateTime.now())}',Colors.lightBlueAccent,context),),
                  SizedBox(width: 10,),
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
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt:'Analytics', content: 'Revenue', icn: FontAwesomeIcons.moneyBill),
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Analytics', content: 'Refund', icn:FontAwesomeIcons.solidWindowClose),
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xff0099f7), cl2: Color(0xfff11712), txt: 'Analytics', content: 'Cashback', icn:FontAwesomeIcons.gift),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream:FirebaseFirestore.instance.collection('RBOOKING').snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              bool book =false;
                              return Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: 'Requests', content: '${snapshot.data!.size}', icn:FontAwesomeIcons.appleAlt,
                                  press: (){
                                    Get.toNamed('/request?booking=$book');
                                  });
                            }
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Bookings').snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              bool book = true;
                              return Box(height: height*0.15, width: width*0.2, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: 'Booked', content: '${snapshot.data!.size}', icn:FontAwesomeIcons.firstOrder,press: (){
                                Get.toNamed('/request?booking=$book');
                              });
                            }
                        ),
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xff667eea), cl2: Color(0xff764ba2), txt:'Analytics', content: 'Request', icn: FontAwesomeIcons.chartPie),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //SizedBox(width: 10,),
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xff1e3c72), cl2: Color(0xff2a5298), txt:'Analytics', content: 'Booking', icn: Icons.show_chart),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('RBOOKING').where('cancel', isEqualTo: true).snapshots(),
                            builder: (context, requestsnapshot) {
                              if(requestsnapshot.data == null){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Bookings').where('cancel', isEqualTo: true).snapshots(),
                                  builder: (context, bookingsnapshot) {
                                    if(bookingsnapshot.data == null){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return Box(height: height*0.15, width: width*0.2, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Cancelled', content: '${requestsnapshot.data!.size+bookingsnapshot.data!.size}', icn: Icons.assistant_photo_outlined);
                                  }
                              );
                            }
                        ),
                        Box(height: height*0.15, width: width*0.2, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: "Analytic's", content: 'Cancel', icn:FontAwesomeIcons.exclamationCircle),
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