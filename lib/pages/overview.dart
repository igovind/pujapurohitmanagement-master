import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/auth.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';

class Overview extends StatelessWidget{
  final String? name;
  const Overview({this.name});
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
                      AutoSizeText('Welcome ${snapshot.data!.data()!['name']} !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('${snapshot.data!.data()!['Image']}'),)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  SizedBox(height: screenSize.height*0.05,),
                  Row(

                    children: [
                    Session('Efficiency: $efficiency%',efficiency>=50?Colors.green:Colors.red.shade900,context),
                    SizedBox(width: 10,),
                   Expanded(child: Session('Session: ${snapshot.data!.data()!['session']}',Colors.redAccent,context),),
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
                            Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Add Task', content: '', icn:Icons.add,press: (){print('helo');},),
                            Box(height: height*0.15, width: width*0.3, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Manage Task', content: 'Active: 2', icn:Icons.precision_manufacturing_rounded),

                          ],
                        ),
                      ):admin!?Padding(
                       padding: const EdgeInsets.only(top:30,left: 30),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Add Task', content: '', icn:Icons.add,press: (){print('helo');}),
                           Box(height: height*0.15, width: width*0.3, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Manage Task', content: 'Active: 2', icn:Icons.precision_manufacturing_rounded),
                         ],
                       ),
                     ):SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top:30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(height: height*0.15, width: width*0.3, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: 'Payments', content: '\₹ ${200.00}', icn:Icons.payments_rounded),
                            Box(height: height*0.15, width: width*0.3, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: 'Upcoming Task', content: '10', icn:Icons.trending_up),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(height: height*0.15, width: width*0.3, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: 'Pending Task', content: '1', icn:Icons.trending_down),
                            Box(height: height*0.15, width: width*0.3, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Completed Task', content: '10', icn: Icons.check_circle)


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
                      AutoSizeText('Welcome ${snapshot.data!.data()!['name']} !',maxFontSize: 24,minFontSize:22,style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),),
                      SizedBox(width: screenSize.width*0.1,),
                      Expanded(child: Session('Efficiency: $efficiency%',efficiency>=50?Colors.green:Colors.red.shade900,context),),
                      SizedBox(width: 10,),
                      Expanded(child: Session('Session:${snapshot.data!.data()!['session']}',Colors.redAccent,context),),
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
                        radius: 30,
                        backgroundImage: NetworkImage('${snapshot.data!.data()!['Image']}'),)
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
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Add Task', content: '', icn:Icons.add),
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Manage Task', content: 'Active: 2', icn:Icons.precision_manufacturing_rounded),
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xff0099f7), cl2: Color(0xfff11712), txt: 'Employee Eff.', content: 'Overall: 80%', icn:Icons.show_chart),
                          ],
                        ),
                      ):admin!?Padding(
                        padding: const EdgeInsets.only(top:30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF56ab2f), cl2: Color(0xffa8e063), txt: 'Add Task', content: '', icn:Icons.add),
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xff4568dc), cl2: Color(0xffb06ab3), txt: 'Manage Task', content: 'Active: 2', icn:Icons.precision_manufacturing_rounded),
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xff0099f7), cl2: Color(0xfff11712), txt: 'Employee Eff.', content: 'Overall: 80%', icn:Icons.show_chart),


                          ],
                        ),
                      ):SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top:30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xFF26D0CE), cl2: Colors.blueAccent, txt: 'Payments', content: '\₹ ${200.00}', icn:Icons.payments_rounded),
                            Box(height: height*0.15, width: width*0.2, cl1:Colors.tealAccent, cl2: Colors.teal[400]!, txt: 'Upcoming Task', content: '10', icn:Icons.trending_up),
                            Box(height: height*0.15, width: width*0.2, cl1: Color(0xFFFF512F), cl2: Color(0xFFDD2476), txt: 'Pending Task', content: '1', icn:Icons.trending_down),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30,left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //SizedBox(width: 10,),
                            Box(height: height*0.15, width: width*0.2, cl1: Colors.orangeAccent, cl2: Colors.orange, txt:'Completed Task', content: '10', icn: Icons.check_circle)
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

 /* InkWell box(double height, double width,Color cl1,Color cl2,String txt,String content,IconData icn) {
    return InkWell(
                          onTap:(){},
                          child: Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                                boxShadow:[
                                  BoxShadow(
                                      color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
                                ] ,
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                    colors: [cl2,cl2]
                                )
                            ),
                            child: Center(
                              child: ListTile(
                                title:Text("$content",style: GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold),),
                                subtitle: Text("$txt",style: GoogleFonts.aBeeZee(color: Colors.white),),
                                trailing: Icon(icn,color:Colors.white,size: 24,),
                              ),
                            ),
                          ),
                        );
  }*/

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

class Box extends StatelessWidget{
  final double height;
  final double width;
  final Color cl1;
  final Color cl2;
  final String txt;
  final String content;
  final IconData icn;
  final VoidCallback? press;
  const Box({this.press,required this.height,required this.width,required this.cl1,required this.cl2,required this.txt,required this.content,required this.icn});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        press!();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
            ] ,
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: [cl2,cl2]
            )
        ),
        child: Center(
          child: ListTile(
            title:AutoSizeText("$content",style: GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold),maxFontSize: ResponsiveWidget.isSmallScreen(context)?12:16,minFontSize: ResponsiveWidget.isSmallScreen(context)?10:14,),
            subtitle: AutoSizeText("$txt",style: GoogleFonts.aBeeZee(color: Colors.white),maxFontSize: ResponsiveWidget.isSmallScreen(context)?12:16,minFontSize: ResponsiveWidget.isSmallScreen(context)?10:14),
            trailing: Icon(icn,color:Colors.white,size:ResponsiveWidget.isSmallScreen(context)?16:24,),
          ),
        ),
      ),
    );
  }

}