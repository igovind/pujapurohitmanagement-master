import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohitmanagement/components/light_colors.dart';
import 'package:switcher/switcher.dart';

class UserDetail extends StatefulWidget {

  @override
  _UserDetailState createState() => _UserDetailState();
}
class _UserDetailState extends State<UserDetail> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 5,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Avaliable_pundit').doc('${Get.parameters['uid']}').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.data==null){
            return Center(child:CircularProgressIndicator());
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                     /* gradient: LinearGradient(
                          colors: [Color(0xFFFFC837), Color(0xFFFF8008)])*/),
                ),
                actions: [
                  TabBar(
                    labelStyle: GoogleFonts.aBeeZee(color:Colors.white),
                    labelColor: Colors.black54,
                    indicatorColor: Colors.orangeAccent,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BubbleTabIndicator(
                       indicatorHeight: 25.0,
                        indicatorColor: Colors.orangeAccent,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)
                    ),
                    tabs: [
                      Tab(
                        text: 'Puja Offering',
                      ),
                      Tab(
                        text: 'Bank detail',
                      ),
                      Tab(
                        text: 'Gallery',
                      ),
                      Tab(
                        text: 'Bookings',
                      ),
                      Tab(
                        text: 'Actions',
                      )
                    ],
                  ),
                  CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 8),
                                blurRadius: 8)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${snapshot.data!.data()!['profilePicUrl']}"))),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: height,
                      width: width / 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.4,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage('${snapshot.data!.data()!['profilePicUrl']}'),
                                  fit: BoxFit.fill
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: SelectableText(
                                    '${snapshot.data!.data()!['firstName']}',
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    autofocus: true,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              snapshot.data!.data()!['verified']!
                                  ? Icon(
                                Icons.verified,
                                color: Colors.orangeAccent,
                                size: 14,
                              )
                                  : Icon(
                                Icons.verified,
                                color: Colors.grey,
                                size: 12,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_history,
                                color: Colors.orangeAccent,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'State : ${snapshot.data!.data()!['state']}',
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'City : ${snapshot.data!.data()!['lastName']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Swastik : ${snapshot.data!.data()!['swastik']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SelectableText(
                            'Contact : ${snapshot.data!.data()!['number']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            autofocus: true,
                          ),
                          Text(
                            'Uid : ${snapshot.data!.data()!['uid']}',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          /* StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.doc("punditUsers/${uid}/user_profile/user_bank_details").snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return Container(height: 10,width: 10,);
                              }
                              final servicess = snapshot.data;
                              return Column(
                                children: [
                                  Text("Bank Name :${servicess.data()['bankName']}"??"not provided"),
                                  Text("Ifsc code :${servicess.data()['IFSC']}"??"not provided"),
                                  Text("Account Number: ${servicess.data()['accountNumber']}"??"not provided"),
                                  Text("Name on bank : ${servicess.data()['name']}"??"not provided")
                                ],
                              );
                            }
                          )*/
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(
                          width: width * 0.7,
                          height: height * 0.8,
                          child: TabBarView(
                            children: [
                              PujaOffering(asyncSnapshot: snapshot),
                              Icon(Icons.account_balance_wallet),
                              Gallery(query: snapshot,),
                              Icon(Icons.directions_bike),
                              Settings(query:snapshot)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        }
      ),
    );
  }

  

  
}

class PujaOffering extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> asyncSnapshot;
 const PujaOffering({required this.asyncSnapshot});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                      'Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final data = snapshot.data!.docs;
                                    List<Widget> pooja = [];
                                    for (var mess in data) {
                                      final String? name = mess.data()['puja'];
                                      final String? keyword = mess.data()['keyword'];
                                      final double? price = mess.data()['price'];
                                      final String? duration = mess.data()['time'];
                                      final String? Samagri = mess.data()['PujanSamagri'];
                                      final String? id = mess.data()['serviceId'];
                                      final subscriber = mess.data()['subscriber'];
                                      final messagewidget = pujaoffering(
                                          name,
                                          keyword,
                                          price,
                                          duration,
                                          Samagri,
                                          subscriber,id);
                                      pooja.add(messagewidget);
                                    }
                                    return ListView(
                                      children: pooja,
                                      shrinkWrap: true,
                                    );
                                  });
  }
  Widget pujaoffering(name, keyword, price, duration, samagri, subscriber,id) {
    void adddocs(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering/$id').update(
          {
            'rates':0,
            'reviews':0
          });
    }
    void addvalueformoney(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering/$id/reviews/cost').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'Cost efficient',
          });
    }
     void addknowlwdge(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering/$id/reviews/Samagri').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'Samagri',
          });
    }
     void addbehaviour(){
        
        FirebaseFirestore.instance.doc('Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering/$id/reviews/satisfaction').set(
          {
            'rate':0,
            'raters':0,
            'type':'specific',
            'name':'Satisfaction',
          });
    }
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            child: Text(
              '$subscriber',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          title: Text(
            '$name',
            style:GoogleFonts.aBeeZee(color: Colors.black54,fontSize: 14, fontWeight: FontWeight.bold),
          ),
          trailing: Text('\₹ $price', style: TextStyle(fontSize: 12)),
          subtitle: Text('$duration', style: TextStyle(fontSize: 12)),
        ),
        SizedBox(height:20),
        Row(
          children: [
          //   kamasan(id,0,price),
          //  kamasan(id,100,price),
          //  kamasan(id,200,price),
          //  kamasan(id,300,price),
          //  kamasan(id,400,price),
          //  kamasan(id,500,price),
          //  kamasan(id,600,price),
          //  kamasan(id,700,price),
          //  kamasan(id,800,price),
          //  kamasan(id,900,price),
          //  kamasan(id,1000,price),
            // kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fpuja2.png?alt=media&token=86a025b0-f401-4271-bed8-477505e2fea9','Festival Puja'),
            //  kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fholika.png?alt=media&token=ba72bbe9-c08d-4580-9f39-0162edd99f94','Festival Puja'),
            //  kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fwest-bengal-durga-puja-celebration-260nw-1189413016-removebg-preview.png?alt=media&token=7220edc9-9844-4001-8339-bfa0a5b8b11a','Festival Puja'),
            //  kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2FJanmastmi.png?alt=media&token=fb2ddfd6-fbe4-4948-8eb6-6eac4286fff1','Festival Puja'),
            //  kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fteej-celebration-india-beautiful-indian-women-s-illustration-teej-celebration-india-beautiful-womne-womens-illustration-smile-134359867-removebg-preview.png?alt=media&token=6a33bf7d-5964-4c6b-8f37-c2a2037b783f','Festival Puja'),
            //  kamasan(id,'#festivalpuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2F35724504-removebg-preview.png?alt=media&token=b6e302a1-9efb-40a9-bd2a-e26f7124b958','Festival Puja'),
            
            // kamasan(id,'#pujaforhealth','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fa72b36b0a355b7982bf38e564e592e47-removebg-preview.png?alt=media&token=bbc294b7-27b7-40c8-ad25-374737ce4073','Puja for health'),
            // kamasan(id,'#pujaforhealth','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fnavgrah.png?alt=media&token=4cf8aedc-8c8d-4bf9-bcab-e16c48a1be40','Puja for health'),
            
            // kamasan(id,'#recomended','Physical','https://1.bp.blogspot.com/-9sV7as2Ql30/XRCtEIpTu0I/AAAAAAAAAc8/fp5sdjsJCL0cGIAcUeB_pssBaXdrrYQtACEwYBhgL/s1600/Shri-Ram-Images.jpg','Recomended'),
            // kamasan(id,'#kath&path','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fpuja1.png?alt=media&token=b62de48d-8fec-4df0-95c0-ed4bac0986fa','Kath & Path'),
            // kamasan(id,'#kath&path','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2FHanuman%20ji.png?alt=media&token=d1127a65-5731-495c-8f15-d661bccbb0e5','Kath & Path'),
            // kamasan(id,'#ceremonypuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fvivah_boy3.png?alt=media&token=445d1305-3bda-4dfd-82b0-9a4409d2a4ee','Ceremony Puja'),
            // kamasan(id,'#ceremonypuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fvivah_girl.png?alt=media&token=a319de1e-9949-4dff-a0cb-2ea1f12b98b2','Ceremony Puja'),
            // kamasan(id,'#ceremonypuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fbhumi-removebg-preview.png?alt=media&token=4cfecb17-c7d9-4b94-bf3b-5a1f78af3b84','Ceremony Puja'),
            // kamasan(id,'#ceremonypuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fghrih-removebg-preview.png?alt=media&token=c2b8950b-cb88-4c8e-aa04-d8a742c7f406','Ceremony Puja'),
            // kamasan(id,'#ceremonypuja','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fupnayan-removebg-preview.png?alt=media&token=9a6a0001-d88f-4a97-bdf7-11102a738875','Ceremony Puja'),
            // kamasan(id,'#pujaforwealth','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FDiwali...png?alt=media&token=aea916ca-8159-426b-b8f5-5aad60e460dd','Puja for wealth'),
            // kamasan(id,'#pujaforwealth','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fganesha%20cartoon%201.png?alt=media&token=57237ae5-ae7c-47da-ade5-68a48b0d026e','Puja for wealth'),
            // kamasan(id,'#pujaforstudy','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2FSaraswati%20Maa.png?alt=media&token=1a00da2c-27c1-4e59-ae05-1be1831b4ff6','Puja for study'),
            // kamasan(id,'#othe','Physical','https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2F14-145898_question-mark-transparent-background-question-mark-png-hd-removebg-preview.png?alt=media&token=f034a1d6-13fc-4641-8f6a-cb353b9dfe40','Other'),
            


          ],
        )
      ],
    );
  }

  //InkWell kamasan(id,type,offer,image,name)
  
  InkWell kamasan(id,double image,double price) {
    return InkWell(
            onTap: (){
              // FirebaseFirestore.instance.collection("Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering").doc(id).update({
              //     'type':name,
              //     'offer':offer,
              //     'image':image
              // }); 
              // FirebaseFirestore.instance.collection('Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/Category').doc(type).set({
              //     'type':type,
              //     'name':name,
              //     'items':1
              // });

              FirebaseFirestore.instance.collection("Avaliable_pundit/${asyncSnapshot.data!.data()!['uid']}/puja_offering").doc(id).update({
                  'np':price+image,
                  
              }); 
            },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
              child: Text("$image"),
            ),
          );
  }

}

class Gallery extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> query;
  const Gallery({required this.query});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .doc(
                                            'Avaliable_pundit/${query.data!.data()!['uid']}/gallery/pics')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                          if (snapshot.data!.exists == false) {
                                            return Center(
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  child: Center(
                                                    child: Text('Not given'),
                                                  ),
                                                ));
                                          }
                                          String? link1 =
                                          snapshot.data!.data()!['link1'];
                                          String? link2 =
                                          snapshot.data!.data()!['link2'];
                                          String? link3 =
                                          snapshot.data!.data()!['link3'];
                                          String? link4 =
                                          snapshot.data!.data()!['link4'];

                                          return GridView.count(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 8.0,
                                            children: [
                                              gallery(link1),
                                              gallery(link2),
                                              gallery(link3),
                                              gallery(link4),
                                            ],
                                            shrinkWrap: true,
                                          );
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .doc(
                                            'punditUsers/${query.data!.data()!['uid']}/user_profile/user_adhaar_details')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                          if (snapshot.data!.exists == false) {
                                            return Center(
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  child: Center(
                                                    child: Text('Not Given adhar'),
                                                  ),
                                                ));
                                          }
                                          String? link1 = snapshot.data!
                                              .data()!['backAdhaarPicUrl'];
                                          String? link2 = snapshot.data!
                                              .data()!['frontAdhaarPicUrl'];

                                          return GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 8.0,
                                            children: [
                                              gallery(link1),
                                              gallery(link2),
                                            ],
                                            shrinkWrap: true,
                                          );
                                        }),
                                  ],
                                ),
                              );
  }
Widget gallery(String? link) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage('$link'),fit: BoxFit.fill) ),
    );
  }

}

class Settings extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> query;
  const Settings({required this.query});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Verification',style: GoogleFonts.aBeeZee(color:Colors.black54),),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .doc('Avaliable_pundit/${query.data!.data()!['uid']}')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                          return Switcher(
                                            value: snapshot.data!.data()!['verified'],
                                            colorOn: Colors.orangeAccent,
                                            colorOff: Colors.grey,
                                            iconOn: Icons.verified,
                                            iconOff: Icons.remove_circle_outline,
                                            onChanged: (bool state) {
                                              FirebaseFirestore.instance
                                                  .doc('Avaliable_pundit/${snapshot.data!.data()!['uid']}')
                                                  .update({'verified': state});
                                              FirebaseFirestore.instance
                                                  .doc(
                                                  'punditUsers/${snapshot.data!.data()!['uid']}/user_profile/user_data')
                                                  .update({'verified': state});
                                            },
                                          );
                                        }),
                                  ],
                                ),
                              ]);
  }

}