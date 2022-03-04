import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurohitPujaTransfer extends StatelessWidget {
  const PurohitPujaTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> map = {
      "satnarayan": "PJID2021824205131",
      "#teej": "PJID2021822181951",
      "#karwachauth": "PJID202182218013",
      "#Vahan": "PJID202182122945",
      "#bhumi": "PJID2021822173446",
      "#durga": "PJID202182217469",
      "#ganesh": "PJID2021822174849",
      "#ghar": "PJID202182217519",
      "#holi": "PJID2021822175320",
      "#janew": "PJID2021822175528",
      "#kali": "PJID2021822175826",
      "#mritunjaya": "PJID202182218734",
      "#laxmipuja": "PJID202182218520",
      "#saraswatipuja": "PJID2021822181540",
      "#janmastmi": "PJID202182218248",
      "#shiv": "PJID20211111153134",
    };
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users_folder/folder/pandit_users')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: TextButton(
                onPressed: () {
                  for (int i = 200; i < snapshot.data!.docs.length; i++) {
                    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore
                        .instance
                        .collection(
                            'punditUsers/${snapshot.data!.docs[i].id}/puja_offering')
                        .snapshots();
                    querySnapshot.listen((event) {
                      for (int j = 0; j < event.size; j++) {
                        if (map[event.docs[j].data()["keyword"]] != null) {
                          FirebaseFirestore.instance
                              .doc(
                                  'users_folder/folder/pandit_users/${snapshot.data!.docs[i].id}/pandit_ceremony_services/${map[event.docs[j].data()["keyword"]]}')
                              .set({
                            'puja_ceremony_id': event.docs[j].data()["pjid"],
                            'puja_ceremony_price':
                                event.docs[j].data()["price"],
                            'puja_ceremony_subscriber':
                                event.docs[j].data()["subscriber"],
                            'puja_ceremony_swastik_gain':
                                event.docs[j].data()["swastik"],
                            'puja_ceremony_time': event.docs[j].data()["time"],
                            'puja_ceremony_keyword':
                                event.docs[j].data()["keyword"],
                            'puja_ceremony_details': null,
                          }).whenComplete(() {
                            FirebaseFirestore.instance
                                .doc(
                                    "users_folder/folder/pandit_users/${snapshot.data!.docs[i].id}/pandit_ceremony_services/${map[event.docs[j].data()["keyword"]]}/puja_ceremony_review/puja_ceremony_samagri_review")
                                .set({
                              'puja_ceremony_samagri_review_name': 'Samagri',
                              'puja_ceremony_samagri_review_rate': 0,
                              'puja_ceremony_samagri_review_raters': 0,
                              'puja_ceremony_samagri_review_type': 'Specific',
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .doc(
                                      "users_folder/folder/pandit_users/${snapshot.data!.docs[i].id}/pandit_ceremony_services/${map[event.docs[j].data()["keyword"]]}/puja_ceremony_review/puja_ceremony_cost_review")
                                  .set({
                                'puja_ceremony_cost_review_name':
                                    'Cost efficient',
                                'puja_ceremony_cost_review_rate': 0,
                                'puja_ceremony_cost_review_raters': 0,
                                'puja_ceremony_cost_review_type': 'Specific',
                              });
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .doc(
                                      "users_folder/folder/pandit_users/${snapshot.data!.docs[i].id}/pandit_ceremony_services/${map[event.docs[j].data()["keyword"]]}/puja_ceremony_review/puja_ceremony_satisfaction_review")
                                  .set({
                                'puja_ceremony_satisfaction_review_name':
                                    'Satisfaction',
                                'puja_ceremony_satisfaction_review_rate': 0,
                                'puja_ceremony_satisfaction_review_raters': 0,
                                'puja_ceremony_satisfaction_review_type':
                                    'Specific',
                              });
                            });
                          });
                        }
                      }
                    });
                  }
                },
                child: Text("Update"),
              ),
            );
          }),
    );
  }
}
