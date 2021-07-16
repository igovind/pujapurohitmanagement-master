import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';
import 'package:pujapurohitmanagement/Controllers/PhoneController.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';

class LoginPage extends GetWidget<FirebaseController>{
  final TextEditingController email =TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
     final PressedState pressedState = Get.put((PressedState()));
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<PressedState>(
        init: PressedState(),
        builder: (pressedState){
          return Center(
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
                          Text('Log In',style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 24
                          ),),
                          // ignore: unnecessary_null_comparison
                          pressedState.pressedBool?TextFormField(
                            controller: phone,
                            maxLength: 13,
                            onChanged: (value){

                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.phone,size: 12,),
                              hintText: 'Enter Number',
                            ),
                          ):SizedBox(),
                          pressedState.pressedBool?SizedBox():TextFormField(
                            controller: email,
                            obscureText:false,
                            maxLength: 30,
                            onChanged: (value){

                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.email,size: 12,),
                              hintText: 'Your email',
                            ),
                          ),
                          pressedState.pressedBool?SizedBox():TextFormField(
                            controller: pass,
                            obscureText:true,
                            maxLength: 6,
                            onChanged: (value){


                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.lock,size: 12,),
                              hintText: 'password',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton
                                (onPressed: ()async{
                                login();
                              },
                                  style: ElevatedButton.styleFrom(primary: LightColors.kDarkYellow),
                                  child:Text('Proceed'))
                            ],
                          ),
                          IconButton(onPressed: () {
                            pressedState.changeStatus();
                          },icon: Icon(pressedState.pressedBool?Icons.email_outlined:Icons.phone_android_outlined,color: LightColors.kDarkYellow,),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildLoginField(int len,String? chan,String hint,IconData iconData,bool obscure) {
    return TextFormField(
                    obscureText: obscure,
                    maxLength: len,
                    onChanged: (value){
                     
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12),
                      prefixIcon: Icon(iconData,color: Colors.black54,size: 12,),
                      hintText: '$hint',
                    ),
                  );
  }
  void login(){
    FirebaseController firebaseController = Get.put(FirebaseController());
    firebaseController.login(email.text, pass.text);
  }
  void phonelogin(){
    controller.webverifyPhone(phone.text,);
  }
}