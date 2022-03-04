import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/Controllers/FirebaseController.dart';

class PujaTransferPage extends StatelessWidget {
  const PujaTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> states = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttarakhand",
      "Uttar Pradesh",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli and Daman & Diu",
      "Delhi",
      "Jammu & Kashmir",
      "Ladakh",
      "Lakshadweep",
      "Puducherry",
    ];
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
                    int i = 2;

                     for (int i = 2; i < 17; i++) {
                    // DocumentSnapshot documentSnapshot=FirebaseFirestore.instance.doc("documentPath")

                    FirebaseFirestore.instance
                        .doc(
                            "assets_folder/puja_ceremony_folder/folder/${snapshot.data!.get("listed_puja")[i]["pjid"]}")
                        .set({
                      "puja_ceremony_name": snapshot.data!.get("listed_puja")[i]
                          ["name"],
                      "puja_ceremony_performing_pandits": 0,
                      "puja_ceremony_promise": null,
                      "puja_ceremony_standard_price": null,
                      "puja_ceremony_steps": null,
                      "puja_ceremony_key_insights": null,
                      "puja_ceremony_display_picture":
                          snapshot.data!.get("listed_puja")[i]["image"],
                      "puja_ceremony_standard_duration":
                          snapshot.data!.get("listed_puja")[i]["avgDuration"],
                      "puja_ceremony_description":
                          snapshot.data!.get("listed_puja")[i]["description"],
                      "puja_ceremony_date_of_creation":
                          snapshot.data!.get("listed_puja")[i]["doc"],
                      "puja_ceremony_type_filter": null,
                      "puja_ceremony_god_filter": null,
                      "puja_ceremony_benefits_filter": null,
                      "puja_ceremony_id": snapshot.data!.get("listed_puja")[i]
                          ["pjid"],
                    }).whenComplete(() {
                      Map<String, String> mapSam = {};
                      for (int r = 0;
                          r <
                              snapshot.data!
                                  .get("listed_puja")[i]["samagri"]
                                      ["Andaman and Nikobar"]
                                  .length;
                          r++) {
                        mapSam.addAll({
                          snapshot.data!.get("listed_puja")[i]["samagri"]
                                  ["Andaman and Nikobar"][r]["id"]:
                              snapshot.data!.get("listed_puja")[i]["samagri"]
                                  ["Andaman and Nikobar"][r]["quantity"]
                        });
                      }
                      for (int j = 0; j < states.length; j++) {
                        FirebaseFirestore.instance
                            .doc(
                                "assets_folder/puja_ceremony_folder/folder/${snapshot.data!.get("listed_puja")[i]["pjid"]}/puja_item_folder/${states[j]}")
                            .set(mapSam);
                      }
                    });
                  }
                   },
                  ),
            );
          }),
    );
  }
}
