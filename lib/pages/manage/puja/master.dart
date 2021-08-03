import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/puja_class.dart';

class Master extends StatelessWidget {
  final List<dynamic> listofPuja;
  final List<dynamic> samList;

  const Master({Key? key, required this.listofPuja, required this.samList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> keyword = [];
    for (int i = 0; i < listofPuja.length; i++) {
      keyword.add(listofPuja[i]["keyword"]);
    }
    print("}}}}KEYWORDS}}}}$keyword");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Avaliable_pundit")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                height: 500,
                child: ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, indexP) {print("$indexP ${snapshot.data!.docs[indexP].id}");
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                "Avaliable_pundit/${snapshot.data!.docs[indexP].id}/puja_offering")
                            .snapshots(),
                        builder: (context, snapshotT) {
                          if (snapshotT.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Center(
                            child: TextButton(
                              child: Text("${indexP+1} Press ----> ${snapshot.data!.docs[indexP].id}"),
                              onPressed: () {
                                print("||||||||||||||||||||||||||||_______________>>>>${indexP +1}");
                                for (int i = 0; i < snapshotT.data!.size; i++) {


                                  if (keyword.contains(
                                      snapshotT.data!.docs[i].get("keyword"))) {
                                    int index = keyword.indexOf(
                                        snapshotT.data!.docs[i].get("keyword"));
                                    String uid =
                                        snapshot.data!.docs[indexP].id; //snapshot.data!.docs[index].id;
                                    ////SAMAGRI SOLUTION//
                                    dynamic samagrilistofpuja =
                                        listofPuja[index]["samagri"]["Delhi"];
                                    //////////////////////
                                    //
                                    //print("||||||||||||||||||||||||||||_______________<<<<<<<$index");
                                    FirebaseFirestore.instance
                                        .doc(
                                            "punditUsers/$uid/puja_offering/${snapshotT.data!.docs[i].id}")
                                        .set({
                                      'puja': listofPuja[index]["name"][1],
                                      'price':
                                          snapshotT.data!.docs[i].get("price"),
                                      'Benefit':
                                          snapshotT.data!.docs[i].get("Benefit"),
                                      'swastik':
                                          snapshotT.data!.docs[i].get("swastik"),
                                      'PanditD': listofPuja[index]["description"]
                                          [1],
                                      'Pujan Samagri': "",
                                      'samagri1': ["", "", "", "", ""],
                                      'samagri2': samagrilistofpuja,
                                      'pjid': listofPuja[index]["pjid"],
                                      'time': snapshotT.data!.docs[i].get("time"),
                                      'keyword':
                                          snapshotT.data!.docs[i].get("keyword"),
                                      'subscriber': snapshotT.data!.docs[i]
                                          .get("subscriber"),
                                      'profit':
                                          snapshotT.data!.docs[i].get("profit"),
                                      'serviceId': snapshotT.data!.docs[i]
                                          .get("serviceId"),
                                      'rates':
                                          snapshotT.data!.docs[i].get('rates'),
                                      'np': snapshotT.data!.docs[i].get("price") +
                                          300,
                                      'reviews': 0,
                                      'image': listofPuja[index]["image"],
                                      'type': snapshot.data!.docs[i].get("type"),
                                      'offer':
                                          snapshotT.data!.docs[i].get("offer")
                                    }).whenComplete(() {
                                      FirebaseFirestore.instance
                                          .doc(
                                              "Avaliable_pundit/$uid/puja_offering/${snapshotT.data!.docs[i].id}")
                                          .set({
                                        'puja': listofPuja[index]["name"][1],
                                        'price':
                                            snapshotT.data!.docs[i].get("price"),
                                        'Benefit': snapshotT.data!.docs[i]
                                            .get("Benefit"),
                                        'swastik': snapshotT.data!.docs[i]
                                            .get("swastik"),
                                        'PanditD': listofPuja[index]
                                            ["description"][1],
                                        'Pujan Samagri': "",
                                        'samagri1': ["", "", "", "", ""],
                                        'samagri2': samagrilistofpuja,
                                        'pjid': listofPuja[index]["pjid"],
                                        'time':
                                            snapshotT.data!.docs[i].get("time"),
                                        'keyword': snapshotT.data!.docs[i]
                                            .get("keyword"),
                                        'subscriber': snapshotT.data!.docs[i]
                                            .get("subscriber"),
                                        'profit':
                                            snapshotT.data!.docs[i].get("profit"),
                                        'serviceId': snapshotT.data!.docs[i]
                                            .get("serviceId"),
                                        'rates':
                                            snapshotT.data!.docs[i].get('rates'),
                                        'np':
                                            snapshotT.data!.docs[i].get("price") +
                                                300,
                                        'reviews': 0,
                                        'image': listofPuja[index]["image"],
                                        'type':
                                            snapshotT.data!.docs[i].get("type"),
                                        'offer':
                                            snapshotT.data!.docs[i].get("offer")
                                      });
                                    });
                                  } else {}
                                }
                              },
                            ),
                          );
                        });
                  },
                ),
              );
            }),
      ),
    );
  }
}
