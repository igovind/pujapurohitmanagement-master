import 'dart:async';
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
import 'package:pujapurohitmanagement/pages/Management.dart';
import 'package:pujapurohitmanagement/pages/dashboard.dart';
import 'package:pujapurohitmanagement/pages/overview.dart';


class MainPage extends StatefulWidget {
  final  String uid;
  final Users users;
  const MainPage({required this.uid, required this.users});

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  var _selectedOption = 1;
  List _isHovering = [false,false];
  List allOptions = [Overview(),Dashboard(),Management()];

  List isSelected = [false,true,false];
  @override
  void initState() {
    /* FirebaseFirestore.instance.collection('Admin').doc('${widget.uid}').update({
      'logins':FieldValue.arrayUnion(['Date: ${DateFormat.yMMMMEEEEd().format(DateTime.now())} Time: ${DateFormat.jm().format(DateTime.now())}']),
      'session':FieldValue.increment(1)
    });*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Admin').doc(widget.uid).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.data==null){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data!.data()!['role']==null){
            return Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: height*0.5,
                        width: width*0.5,
                        child: Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/11104.png?alt=media&token=acd10181-53c1-4658-ba0f-1b619dd25839')),
                    SizedBox(height: 10,),
                    Text('Opps',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Website is only for Admin Use..',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: ()async{
                      try{
                        EasyLoading.show(status: 'loading');
                        await auth.signOut().whenComplete(() {
                          EasyLoading.showSuccess('Logged out').whenComplete((){
                          });
                        });
                      }
                      catch(e){
                        EasyLoading.showError('${e.toString()}',duration: Duration(seconds: 3));
                      }
                    },
                      child: Text('Log Out'),style: ElevatedButton.styleFrom(primary: LightColors.kDarkYellow),)
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: ResponsiveWidget.isSmallScreen(context)?AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ):PreferredSize(child: SizedBox(), preferredSize: Size(screenSize.width,1000)),
            drawer: ResponsiveWidget.isSmallScreen(context)?Drawer(
              elevation: 0.0,
              child:Container(
                padding: EdgeInsets.only(left:10,right: 10,top: 50),
                height: height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907')
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      buildOption(Icons.bubble_chart_outlined, "Overview", 0),
                      buildOption(Icons.dashboard_outlined, "Dashboard", 1),
                      buildOption(Icons.precision_manufacturing_outlined, "Manage", 2),
                    ],
                  ),
                ),
              ) ,
            ):SizedBox(),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveWidget.isSmallScreen(context)?SizedBox():Container(
                  padding: EdgeInsets.only(left:10,right: 10,top: 50),
                  height: height,
                  width: width*0.15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.white12,blurRadius: 20)]
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: 90,width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Flogoupdate.png?alt=media&token=8166394e-d854-4ba8-9f78-741b712ac907')
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        buildOption(Icons.bubble_chart_outlined, "Overview", 0),
                        buildOption(Icons.dashboard_outlined, "Dashboard", 1),
                        buildOption(Icons.precision_manufacturing_outlined, "Manage", 2),
                      ],
                    ),
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)?Container(
                  padding: EdgeInsets.only(top: 50),
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.white12,blurRadius: 20)]
                  ),
                  child: allOptions[_selectedOption],
                ):Container(
                  padding: EdgeInsets.only(top: 50),
                  height: height,
                  width: width*0.85,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.white12,blurRadius: 20)]
                  ),
                  child: allOptions[_selectedOption],
                )
              ],
            ),
          );
        }
    );
  }
  buildOption(IconData iconData,String txt, int index) {
    return Column(

      children: [
        isSelected[index]
            ? Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.white))
            : Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.transparent)),
        SizedBox(height: 5.0),
        GestureDetector(onTap: () {
          setState(() {
            _selectedOption = index;
            isOptionSelected(index);
          });

        },
          child:ResponsiveWidget.isMediumScreen(context)?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: isSelected[index]?LightColors.kDarkYellow:Colors.white,
                child: Center(child: Icon(iconData,color: isSelected[index]?Colors.white:Colors.grey,)),
              ),
            ],):Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: isSelected[index]?LightColors.kDarkYellow:Colors.white,
                child: Center(child: Icon(iconData,color: isSelected[index]?Colors.white:Colors.grey,)),
              ),
              SizedBox(width: 10,),
              Expanded(
                  flex: 2,
                  child: AutoSizeText("$txt",style: GoogleFonts.aBeeZee(color: isSelected[index]?Colors.black54:Colors.grey,),maxFontSize:isSelected[index]?14:12,minFontSize: isSelected[index]?12:10 ,))
            ],
          ),
        )
      ],
    );
  }
  isOptionSelected(index) {
    var previousIndex = isSelected.indexOf(true);
    isSelected[index] = true;
    isSelected[previousIndex] = false;
  }
}