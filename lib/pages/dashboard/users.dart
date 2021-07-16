import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';
import 'package:switcher/switcher.dart';

class AvailableUsers extends StatefulWidget{
  @override
  _AvailableUsersState createState() => _AvailableUsersState();
}
int limit=10;
String? serch;
String? search;
int? total_user =10;
int? total_pandit=10;
int? incrementer =10;
bool use = false;
bool astro = false;
class _AvailableUsersState extends State<AvailableUsers> {
  @override
  void initState() {
    if(Get.parameters['type'] == 'true'){setState(() {
      setState(() {
        use=true;
      });
    });}
    else{
      setState(() {
        use=false;
      });
    }
    if(Get.parameters['astro'] == 'true'){setState(() {
      setState(() {
        astro=true;
      });
    });}
    else{
      setState(() {
        astro=false;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            limit+= incrementer!;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: LightColors.firstSlice,
            shape: BoxShape.circle
          ),
          child: Center(child: Text('More',style: GoogleFonts.aBeeZee(fontSize: 8,color: Colors.white),),),
        ),
      ),
      body: use?SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Session('Total : 296', LightColors.firstSlice, context),

                Container(width: ResponsiveWidget.isSmallScreen(context)?width*0.3:width*0.2,
                  height: height*0.05,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.black12)
                  ),
                  child: Center(
                    child: TextFormField(
                      style: GoogleFonts.aBeeZee(fontSize: 12),
                      onChanged: (value){
                        setState(() {
                          serch = value;
                          search = value.toUpperCase();
                          print(search);
                          print(serch);
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.search,size: 12,color: LightColors.firstSlice,),
                        hintStyle: GoogleFonts.aBeeZee(fontSize: 11),
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              height: height,
              width: width,
              child: Scrollbar(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').where('name',isGreaterThanOrEqualTo: serch).orderBy('name',).limit(limit).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      total_user = snapshot.data!.size;
                      final services = snapshot.data!.docs;
                      List<Widget> cards=[];
                      for (var mess in services){
                        final name = mess.data()['name'];
                        final phone = mess.data()['phone'];
                        final email = mess.data()['email'];
                        final age = mess.data()['age'];
                        final image = mess.data()['photoUrl'];
                        final uid = mess.data()['uid'];
                        final mw=UserCard(uid: uid,superadmin: Get.parameters['superadmin']!=null,name: name,phone: phone,age: age,email: email,image: image,);
                        cards.add(mw);
                      }
                      return GridView.count(
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2:ResponsiveWidget.isMediumScreen(context)?3:4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: cards,
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      )
          :Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Session('Total : $total_pandit', LightColors.firstSlice, context),
                  Session('Incrementer : $incrementer', LightColors.kDarkYellow, context),
                  IconButton(icon: Icon(Icons.add,size: 12,),color: Colors.greenAccent,onPressed:(){
                    setState(() {
                      incrementer = incrementer!+20;
                    });
                  }),
                  Container(width: ResponsiveWidget.isSmallScreen(context)?width*0.3:width*0.2,
                    height: height*0.05,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Center(
                      child: TextFormField(
                        style: GoogleFonts.aBeeZee(fontSize: 12),
                        onChanged: (value){
                          setState(() {
                            serch = value;
                            search = value.toUpperCase();
                            print(search);
                            print(serch);
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.search,size: 12,color: LightColors.firstSlice,),
                          hintStyle: GoogleFonts.aBeeZee(fontSize: 11),
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                height: height,
                width: width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: astro?FirebaseFirestore.instance.collection('Avaliable_pundit').where('astrologer', isEqualTo: true).limit(limit).snapshots():FirebaseFirestore.instance.collection('Avaliable_pundit').where('firstName', isGreaterThanOrEqualTo: serch).limit(limit).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      total_pandit = snapshot.data!.size;
                      final services = snapshot.data!.docs;
                      List<Widget> cards=[];
                      for (var mess in services){
                        final name = mess.data()['firstName'];
                        final phone = mess.data()['number'];
                        final swastik = mess.data()['swastik'];
                        final astro = mess.data()['astrologer'];
                        final image = mess.data()['profilePicUrl'];
                        final city = mess.data()['lastName'];
                        final state = mess.data()['state'];
                        final uid = mess.data()['uid'];
                        final verify= mess.data()['verified'];
                        final online=mess.data()['online'];
                        final mw=PanditCard(online:online,verify:verify,uid: uid,superadmin: Get.parameters['superadmin']!=null,city: city,state:state,name: name,phone: phone,swastik: swastik,astro: astro ,image: image,);
                        cards.add(mw);
                      }
                      return GridView.count(
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2:ResponsiveWidget.isMediumScreen(context)?3:4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: cards,
                      );
                    }
                ),
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
class UserCard extends StatelessWidget{
  final String? name;
  final String? image;
  final String? phone;
  final String? email;
  final int? age;
  final bool? superadmin;
  final String? uid;
  UserCard({required this.uid,this.superadmin,this.name,this.email,this.image,this.phone,this.age});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
   return Container(
    // height: ResponsiveWidget.isSmallScreen(context)?height*0.3:230,
    // width: ResponsiveWidget.isSmallScreen(context)?width*0.2:180,
     decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),

     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
           height: ResponsiveWidget.isSmallScreen(context)? 50:85,width: ResponsiveWidget.isSmallScreen(context)? 50:85,
           decoration: BoxDecoration(
               color: Colors.white,
               shape: BoxShape.circle,
               image: DecorationImage(
                   image: NetworkImage('$image'),
                   fit: BoxFit.fill
               )
           ),
         ),
         SizedBox(height: 5,),
         AutoSizeText('$name',style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
         superadmin!?AutoSizeText('$phone',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,):SizedBox(),
         AutoSizeText('$uid',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?6:8,maxFontSize: ResponsiveWidget.isSmallScreen(context)?8:9 ,),
         AutoSizeText('$email',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
         AutoSizeText('Age : $age',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
         AutoSizeText('State : ??',style: GoogleFonts.aBeeZee(color: Colors.black54),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
         AutoSizeText('Joined : ??',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,)
       ],
     ),
   );
  }

}
class PanditCard extends StatelessWidget{
  final String? name;
  final String? image;
  final String? phone;
  final String? state;
  final String? city;
  final double? swastik;
  final bool? astro;
  final int? age;
  final bool? superadmin;
  final String? uid;
  final bool? verify;
  final bool? online;
  PanditCard({this.online,this.verify,required this.uid,this.superadmin,this.city,this.state,this.astro,this.name,this.swastik,this.image,this.phone,this.age});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    void adddocs(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/$uid').update(
          {
            'rates':0,
            'reviews':0
          });
    }
    void addvalueformoney(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/$uid/reviews/value').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'Value for money',
          });
    }
     void addknowlwdge(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/$uid/reviews/knowledge').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'knowledge',
          });
    }
     void addbehaviour(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/$uid/reviews/behaviou').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'Behaviour',
          });
    }
    void addall(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/$uid/Category/All').set(
          {
            'items':0,
            
            'name':'All',
            'type':'#all',
          });
    }

    return InkWell(
    
      onTap: (){
        //addall();
        //  adddocs();
        //  addvalueformoney();
        //  addbehaviour();
        //  addknowlwdge();
        Get.toNamed('/pandit_detail?uid=$uid&name=$name&city:$city&verify:$verify&image=$image');
      },
      child: Container(
        // height: ResponsiveWidget.isSmallScreen(context)?height*0.3:230,
        // width: ResponsiveWidget.isSmallScreen(context)?width*0.2:180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: ResponsiveWidget.isSmallScreen(context)? 50:80,width: ResponsiveWidget.isSmallScreen(context)? 50:80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('$image'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(height: 15,),
            AutoSizeText('$name',style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11 ,),
            superadmin!?AutoSizeText('$phone',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11 ,):SizedBox(),
            AutoSizeText('$uid',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?6:8,maxFontSize: ResponsiveWidget.isSmallScreen(context)?8:9 ,),
            AutoSizeText('swastik : $swastik',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11 ,),
            AutoSizeText('Astro : ${astro!?'Astro':'Not Astro'}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:10,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11 ,),
            AutoSizeText('State : $city , $state',style: GoogleFonts.aBeeZee(color: Colors.black54),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?10:11 ,),
            astro!?Switcher(
              value: online!,
              colorOn: Colors.green,
              colorOff: Colors.grey,
              iconOn: Icons.circle_notifications,
              iconOff: Icons.remove_circle_outline,
              onChanged: (bool state) {
                FirebaseFirestore.instance
                    .doc('Avaliable_pundit/$uid')
                    .update({'online': state});
                FirebaseFirestore.instance
                    .doc(
                    'punditUsers/${Get.parameters['uid']}/user_profile/user_data')
                    .update({'online': state});
              },
            ):SizedBox()
          ],
        ),
      ),
    );
  }

}
