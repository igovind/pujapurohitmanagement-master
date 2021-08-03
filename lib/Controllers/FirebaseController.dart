import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pujapurohitmanagement/Controllers/UserController.dart';
import 'package:pujapurohitmanagement/main.dart';
import 'package:pujapurohitmanagement/newdatabase.dart';
import 'package:pujapurohitmanagement/pages/Temporay.dart';
import 'package:pujapurohitmanagement/users.dart';

import '../root.dart';

class FirebaseController extends GetxController{
  String? phoneNo, smssent, sms, verificationId,errorMessage;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  void onInit(){
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password){

  }

  void login(String email,String password)async{
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      Get.offAll(Controller());
    }).catchError((error){
      Get.snackbar('Error', error.message);
    });
  }

  void signOut()async{
   await  _auth.signOut().catchError((error){
      Get.snackbar('Error', error.message,maxWidth: 400);
   });
  }

  webverifyPhone(String phone)async{
    ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(
        '${phone}').catchError((error){
       Get.snackbar('Error', error.message);
    });
    // UserCredential userCredential = await confirmationResult.confirm('$sms');
   Get.defaultDialog(
      title: 'OTP Verification',
      content: Container(
        width: Get.width,
        child: Column(
          children: [
             RichText(text: TextSpan(
               text: "Enter the OTP send to ",style:GoogleFonts.aBeeZee(),
               children:[
                 TextSpan(text: '$phone',style: GoogleFonts.aBeeZee(color:Colors.black54,fontWeight: FontWeight.bold)),
               ]
             )),
            SizedBox(height:10),
            SizedBox(
              height: Get.height*0.4,
              child: Center(child: Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fsecurity-otp-one-time-password-smartphone-shield_9904-104-removebg-preview.png?alt=media&token=abd4fe30-d744-4de0-a2fe-09b9b0d6b7d5',)),
            ),
            
            SizedBox(height:10),
            SizedBox(
              width: Get.width*0.4,
              child: OTPTextField(
                length: 6,
                style: TextStyle(
                    fontSize: 17
                ),
                onCompleted: (pin) {
                  this.sms=pin;
                },
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: ()async{
                  await confirmationResult.confirm('$sms').catchError((err){
                    Get.snackbar('Error', err.message);
                    Get.back();
                  });
                  Get.offAll(GetxC());
                },
                child: Text(
                  'VERIFY & PROCEED',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),

    );

  }
}