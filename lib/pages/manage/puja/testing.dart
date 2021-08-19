import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Avaliable_pundit")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }

            return Center(
              child: TextButton(
                onPressed: () {
                  print(
                      "Hi ${snapshot.data!.docs.length}, ${snapshot.data!.docs[1]}");

                   for(int i=0;i<snapshot.data!.size;i++){
                  dynamic astro = snapshot.data!.docs[i].get("astrologer");
                  print("$astro");
                   if (astro == false) {
                  FirebaseFirestore.instance
                        .doc(
                            "punditUsers/${snapshot.data!.docs[i].id}/user_profile/user_data")
                        .update({"language": "Hindi", "experience": "2 Years"});
                   }
                }
                    },
                child: Text("press"),
              ),
            );
          }),
    );
  }
}
