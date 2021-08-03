import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/puja_class.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/puja_tile.dart';

import 'magic_screen.dart';
import 'new_puja_add_form.dart';

class AddNewPuja extends StatelessWidget {
  final List<dynamic> samagriList;
  final List<dynamic> pujaList;
  final List<dynamic> types;

  const AddNewPuja(
      {Key? key,
      required this.samagriList,
      required this.pujaList,
      required this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Listed Puja"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Total Puja ${pujaList.length}"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Add"),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .doc("inventories/state")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return PujaAddForm(
                          types: types,
                          samagriList: samagriList,
                          stateList: snapshot.data!.get("states"),
                          languageCode: "HIN",
                        );
                      }));
            },
          );
        },
      ),
      backgroundColor: Colors.blueAccent,
      body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.doc("inventories/state").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<dynamic> states = snapshot.data!.get("states");

            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      Puja puja = Puja(
                          samagriList: samagriList,
                          state: states,
                          languageCode: "ENG",
                          value: pujaList,
                          index: index);
                      return PujaTile(
                        initialDetails: pujaList[index],
                        stateList: states,
                        types: types,
                        index: index,
                        mainSamagriList: samagriList,
                        samagri: puja.samagri,
                        name: puja.name,
                        uid: "UserDetails(snapshot: userData).uid",
                        languageCode: "ENG",
                        keyword: puja.keyword,
                        type: puja.keyword,
                        description: puja.description,
                        image: puja.image,
                        duration: puja.duration,
                        pjid: puja.id,
                        price: "2000",
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                        height: MagicScreen(height: 30, context: context)
                            .getHeight),
                    itemCount: pujaList.length));
          }),
    );
  }
}
