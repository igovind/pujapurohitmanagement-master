import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc("inventories/listed_puja").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.data==null){
            return CircularProgressIndicator();
          }
          List<dynamic> list=snapshot.data!.get("listed_puja");

          return Center(
            child: TextButton(onPressed: () {
              for(int i=0;i<list.length;i++){
                FirebaseFirestore.instance.doc("inventories/listed_puja").update(
                    {
                      "listed_puja":FieldValue.arrayRemove(list[i]),
                    }).whenComplete(() => {

                });
              }
            }, child: Text("press"),),
          );
        }
      ),
    );
  }
}
