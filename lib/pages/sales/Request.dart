import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:pujapurohitmanagement/components/responsive.dart';

class Request extends StatefulWidget{
  @override
  _RequestState createState() => _RequestState();
}
int? rsearch;
int? total;
bool booking = true;
class _RequestState extends State<Request> {
  @override
  void initState() {
    if(Get.parameters['booking']=='true'){
      setState(() {
        booking=true;
      });
    }
    else{
      setState(() {
        booking=false;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Session('Total : $total', LightColors.firstSlice, context),

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
                          rsearch = int.parse(value);
                          print(rsearch);

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
                child: booking?StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Bookings').orderBy('timestrap', descending : true ).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      total = snapshot.data!.size;
                      final services = snapshot.data!.docs;
                      List<Widget> cards=[];
                      for (var mess in services){
                        final due = mess.data()['AmountPaid'];
                        final client = mess.data()['client'];
                        final clientuid = mess.data()['clientuid'];
                        final buid = mess.data()['pandituid'];
                        final uimage = mess.data()['pic'];
                        final bimage = mess.data()['panditpic'];
                        final date = mess.data()['date'] +  mess.data()['time'];
                        final bname= mess.data()['pandit'];
                        final service = mess.data()['service'];
                        final id = mess.data()['bookingId'];
                        final cancel = mess.data()['cancel'];
                        final rejected = mess.data()['rejected'];
                        final puja_status = mess.data()['puja_status'];
                        final contact = mess.data()['contact'];
                        final mw=BookingCard(contact:contact,puja_status:puja_status, rejected: rejected, booking: true,cancel:cancel,bookingId:id,due:due,client:client,clientuid:clientuid,buid:buid,uimage:uimage,bimage:bimage,date:date,bname:bname,service:service);
                        cards.add(mw);
                      }
                      return GridView.count(
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2:ResponsiveWidget.isMediumScreen(context)?3: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: cards,
                      );
                    }
                ):
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('RBOOKING').orderBy('timestrap', descending : true ).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      total = snapshot.data!.size;
                      final services = snapshot.data!.docs;
                      List<Widget> cards=[];
                      for (var mess in services){
                        final due = mess.data()['Due'];
                        final client = mess.data()['client'];
                        final clientuid = mess.data()['clientuid'];
                        final buid = mess.data()['pandituid'];
                        final uimage = mess.data()['pic'];
                        final bimage = mess.data()['panditpic'];
                        final date = mess.data()['date'] +  mess.data()['time'];
                        final bname= mess.data()['pandit'];
                        final service = mess.data()['service'];
                        final id = mess.data()['bookingId'];
                        final cancel = mess.data()['cancel'];
                        final rejected = mess.data()['rejected'];
                        final puja_status = mess.data()['puja_status'];
                        final contact = mess.data()['contact'];
                        final mw=BookingCard(contact: contact,puja_status:puja_status, rejected: rejected, booking: false,cancel:cancel,bookingId:id,due:due,client:client,clientuid:clientuid,buid:buid,uimage:uimage,bimage:bimage,date:date,bname:bname,service:service);
                        cards.add(mw);
                      }
                      return GridView.count(
                        crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2:ResponsiveWidget.isMediumScreen(context)?3: 4,
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

class BookingCard extends StatefulWidget{
  final bool? booking;
  final bool? cancel;
  final double? due ;
  final String? client ;
  final String? clientuid;
  final String? buid;
  final String? uimage ;
  final String? bimage ;
  final String? date;
  final String? bname;
  final String? service;
  final int? bookingId;
  final bool? rejected;
  final bool? puja_status;
  final String? contact;
  const BookingCard({this.contact,this.puja_status,this.rejected,this.booking,this.cancel,this.bookingId,this.due,this.clientuid,this.client,this.buid,this.uimage,this.bimage,this.date,this.bname,this.service});

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: ResponsiveWidget.isSmallScreen(context)? 70:100,width: ResponsiveWidget.isSmallScreen(context)? 70:100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${widget.uimage}'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: ResponsiveWidget.isSmallScreen(context)? 70:100,width: ResponsiveWidget.isSmallScreen(context)? 70:100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${widget.bimage}'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        AutoSizeText('Client : ${widget.client}',style: GoogleFonts.aBeeZee(color: Colors.black54,fontWeight: FontWeight.bold),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
        AutoSizeText('Pandit : ${widget.bname}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?6:8,maxFontSize: ResponsiveWidget.isSmallScreen(context)?8:9 ,),
        AutoSizeText('Id: ${widget.bookingId}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
        AutoSizeText('Service : ${widget.service}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
        AutoSizeText('Booking date : ${widget.date}',style: GoogleFonts.aBeeZee(color: Colors.black54),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
        AutoSizeText('Due/Amount : ${widget.due}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),
        
       widget.booking!?
       AutoSizeText('Status : ${widget.cancel!?'Cancelled': widget.puja_status!?'Booking Colmpleted':'Booking Active'}',style: GoogleFonts.aBeeZee(color: widget.cancel!?Colors.red: widget.puja_status!?Colors.green:Colors.orangeAccent,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,)
       :AutoSizeText('Status : ${widget.cancel!?'Cancelled':widget.rejected!?'Canceled by purohit':'Request Active'}',style: GoogleFonts.aBeeZee(color: widget.cancel!?Colors.red:Colors.green,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,)
       
      ],
            ),
          ],
        ),
    ), 
      //Flip Part
      back: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        
        ),
        child: Center(child: AutoSizeText('${widget.client} Contact : ${widget.contact}',style: GoogleFonts.aBeeZee(color: Colors.black54,),minFontSize:ResponsiveWidget.isSmallScreen(context)?8:9,maxFontSize: ResponsiveWidget.isSmallScreen(context)?9:11 ,),),
      ));
  }
}