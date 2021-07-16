import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/auth.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';

class D3 extends StatefulWidget{
  @override
  _D3State createState() => _D3State();
}

class _D3State extends State<D3> {
  List<Color> colors=[
  Color(0xFFF8FBFF),
  Color(0xFFFCFDFD),
  ];
String? name;
String? year;
String? link;
  @override
  Widget build(BuildContext context) {
     final auth = Provider.of<AuthBase>(context,listen: false);
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Center(
        child: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.white12,blurRadius: 10.0)
            ]
          ),
          height: height*0.8,
          width: width*0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResponsiveWidget.isSmallScreen(context)?SizedBox():Container(
                height: height*0.8,
                width: width*0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/5261740.png?alt=media&token=e17ca189-ad7e-4eba-839f-82d738007ecb')
                  )
                ),
              ),
              Container(
                width: ResponsiveWidget.isSmallScreen(context)?width*0.6:width*0.3,
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResponsiveWidget.isSmallScreen(context)?Container(
                        width: width*0.3,
                        height: height*0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/5261740.png?alt=media&token=e17ca189-ad7e-4eba-839f-82d738007ecb')
                            )
                        ),
                      ):SizedBox(),
                      Text('Update Date',style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 24
                      ),),
                      TextFormField(
                        obscureText:false,                        
                        onChanged: (value){
                          setState(() {
                            year=value;
                          });
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          prefixIcon: Icon(Icons.email,size: 12,),
                          hintText: '29, चैत्र 2078',
                        ),
                      ),
                      TextFormField(
                                 
                        onChanged: (value){
                          setState(() {
                            name=value;
                          });
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          prefixIcon: Icon(Icons.lock,size: 12,),
                          hintText: 'शुक्ल पक्ष, चतुर्दशी',
                        ),
                      ),
                       TextFormField(
                        obscureText:false,                        
                        onChanged: (value){
                          setState(() {
                            link=value;
                          });
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          prefixIcon: Icon(Icons.email,size: 12,),
                          hintText: 'Moon image link',
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton
                            (onPressed: ()async{
                             FirebaseFirestore.instance.doc('/Hindudate/Swastik').update({
                                      'dateyear':year,
                                      'detail':name,
                                      'Moon':link,
                                    }).whenComplete(() {
                                      Get.defaultDialog(title: 'Update',middleText: 'Sucesfully Updated');
                                    });
                          },
                              style: ElevatedButton.styleFrom(primary: LightColors.kDarkYellow),
                              child:Text('Proceed'))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return D3Large();
  }

}
class D3Large  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Update",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Hindu",
                          color: Color(0xFF8591B0))),
                  RichText(
                    text: TextSpan(
                        text: "Hindu Calender",
                        style:
                        TextStyle(fontSize: 60, color: Color(0xFF8591B0)),
                        children: [
                          TextSpan(
                              text: "",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))
                        ]),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Text('Hello')),
                ],
              );
  }

}


class fields extends StatefulWidget{
  @override
  _fieldsState createState() => _fieldsState();
}

class _fieldsState extends State<fields> {
  

  String? email;

  String? password;
  String? link;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right:100),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
              right: ResponsiveWidget.isSmallScreen(context) ? 4 : 74,
              top: 10,
              bottom: 40,
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: TextField(
                          onChanged: (value){
                            email=value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '23, Ashwina (Adhik) 2077'),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
              right: ResponsiveWidget.isSmallScreen(context) ? 4 : 74,
              top: 10,
              bottom: 40,
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: TextField(
                          onChanged: (value){
                            password=value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Krishna Paksha, Ashtami'),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
              right: ResponsiveWidget.isSmallScreen(context) ? 4 : 74,
              top: 10,
              bottom: 40,
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: TextField(
                          onChanged: (value){
                            link=value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Link'),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:100,right:150),
            child: ElevatedButton(
              child: Text('Update'),
              onPressed: (){
              FirebaseFirestore.instance.doc('/Hindudate/Swastik').update({
                'dateyear':email,
                'detail':password,
                'Moon':link,
              }).whenComplete(() {
                Get.defaultDialog(title: 'Update',middleText: 'Sucesfully Updated');
              });
            },
            ),
          )
        ],
      ),
    );
  }
}