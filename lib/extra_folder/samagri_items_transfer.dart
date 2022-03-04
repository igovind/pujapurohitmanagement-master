import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SamagriTransfer extends StatelessWidget {
  const SamagriTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Puja Transfer"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .doc("inventories/listed_puja")
              .snapshots(),
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
                  for(int i=0;i<snapshot.data!.get("listed_samagri").length;i++){
                    FirebaseFirestore.instance
                        .doc(
                        "assets_folder/puja_items_folder/folder/${snapshot.data!.get("listed_samagri")[i]["sid"]}")
                        .set({
                      "puja_item_name": snapshot.data!.get("listed_samagri")[i]["name"],
                      "puja_item_price":snapshot.data!.get("listed_samagri")[i]["avg_price"],
                      "puja_item_margin":snapshot.data!.get("listed_samagri")[i]["commission"],
                      "puja_item_description":snapshot.data!.get("listed_samagri")[i]["description"],
                      "puja_item_display_picture":snapshot.data!.get("listed_samagri")[i]["image"],
                      "puja_item_id":snapshot.data!.get("listed_samagri")[i]["sid"],
                      "puja_item_vendors":snapshot.data!.get("listed_samagri")[i]["sid"],
                    });
                  }
                },
              ),
            );
          }),
    );
  }
}
