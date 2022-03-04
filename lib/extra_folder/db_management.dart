import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbManagement extends StatelessWidget {
  const DbManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database Management UI"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: TextButton(
                child: Text("Press Button"),
                onPressed: () {
/*                  snapshot.data?.docs.forEach((element) {
                    FirebaseFirestore.instance.doc("users_folder/folder/client_users${element.id}").set({
                      'client_name':element.get('name'),
                      'client_address':element.get('address'),
                      'client_age':element.get('age'),
                      'client_email':element.get('email'),
                      'client_mobile_number': element.get('phone'),
                      'client_display_profile':element.get('photoUrl'),
                      'client_joining_date':element.get('joining'),
                      'client_location_latitude':element.get('lat'),
                      'client_location_longitude':element.get('lng'),
                      'client_token_id':element.get('token'),
                      'client_uid':element.get('uid'),
                    });
                  });*/
                int? len=snapshot.data?.size;
                  for(int i=2000;i<len!;i++){
                  //int i=0;
                    bool? checkLocation=snapshot.data?.docs[i].data().containsKey("address");
                    bool? checkLong=snapshot.data?.docs[i].data().containsKey("lng");
                    bool? checkLat=snapshot.data?.docs[i].data().containsKey("lat");
                    if(checkLocation!&&checkLat!&&checkLong!){

                      bool? checkClientName=snapshot.data?.docs[i].data().containsKey("name");
                      bool? checkAge=snapshot.data?.docs[i].data().containsKey("age");
                      bool? checkEmail=snapshot.data?.docs[i].data().containsKey("email");
                      bool? checkMobile=snapshot.data?.docs[i].data().containsKey("phone");
                      bool? checkPhotoUrl=snapshot.data?.docs[i].data().containsKey("photoUrl");
                      bool? checkJoining=snapshot.data?.docs[i].data().containsKey("joining");
                      bool? checkToken=snapshot.data?.docs[i].data().containsKey("token");

                      FirebaseFirestore.instance.doc("users_folder/folder/client_users/${snapshot.data?.docs[i].id}").set({
                        'client_name':checkClientName!?snapshot.data?.docs[i].get('name'):null,
                        'client_location':snapshot.data!.docs[i].get('address'),
                        'client_age':checkAge!?snapshot.data?.docs[i].get('age'):null,
                        'client_email':checkEmail!?snapshot.data?.docs[i].get('email'):null,
                        'client_mobile_number': checkMobile!?snapshot.data?.docs[i].get('phone'):null,
                        'client_display_profile':checkPhotoUrl!?snapshot.data?.docs[i].get('photoUrl'):null,
                        'client_joining_date':checkJoining!?snapshot.data?.docs[i].get('joining'):null,
                        'client_location_latitude':snapshot.data?.docs[i].get('lat'),
                        'client_location_longitude':snapshot.data?.docs[i].get('lng'),
                        'client_token_id':checkToken!?snapshot.data?.docs[i].get('token'):null,
                        'client_uid':snapshot.data?.docs[i].id,
                      });
                    }
                 }
                  dynamic name=snapshot.data?.docs[0].data().containsKey("r");
                  print("Hello ${snapshot.data?.size}");
                },
              ),
            );
          }),
    );
  }
}
