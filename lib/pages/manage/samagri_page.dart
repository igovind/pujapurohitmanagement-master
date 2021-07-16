import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/puja_form.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_form.dart';

class SamagriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SamagriForm(
                    edit: false,
                    description: ["", "", "", "", ""],
                    name: ["", "", "", "", ""],
                    image: "",
                    priceList: {},
                    sid: "",
                  )));
        },
      ),
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .doc("inventories/listed_samagri")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<dynamic> list = snapshot.data!.get("samagri");
            if (list.isEmpty) {
              return Center(child: Text("Kahli hai"));
            }
            List<dynamic> nameE = [];
            List<dynamic> nameH = [];
            List<dynamic> nameB = [];
            List<dynamic> nameT = [];
            List<dynamic> nameL = [];
            List<dynamic> image = [];
            List<dynamic> descriptionE = [];
            List<dynamic> descriptionH = [];
            List<dynamic> descriptionB = [];
            List<dynamic> descriptionT = [];
            List<dynamic> descriptionL = [];
            List<dynamic> sId = [];
            Map<String, dynamic> priceList = {};
            for (int i = 0; i < list.length; i++) {
              nameE.add(list[i]["name"][0]);
              nameH.add(list[i]["name"][1]);
              nameB.add(list[i]["name"][2]);
              nameT.add(list[i]["name"][3]);
              nameL.add(list[i]["name"][4]);
              image.add(list[i]["image"]);
              descriptionE.add(list[i]["description"][0]);
              descriptionH.add(list[i]["description"][1]);
              descriptionB.add(list[i]["description"][2]);
              descriptionT.add(list[i]["description"][3]);
              descriptionL.add(list[i]["description"][4]);
              priceList.addAll(list[i]["price"]);
              sId.add(list[i]["sid"]);
            }
            print("${list[0]["name"][0]} MMMMM $priceList");
            return Center(
              child: SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange[50],
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
                // color: Colors.deepOrange[50],
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                          title: Text("${nameE[index]}"),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${sId[index]}",
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${descriptionE[index]}")
                            ],
                          ),
                          leading: Image.network("${image[index]}"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SamagriForm(
                                      name: [
                                        nameE[index],
                                        nameH[index],
                                        nameB[index],
                                        nameT[index],
                                        nameL[index],
                                      ],
                                      description: [
                                        descriptionE[index],
                                        descriptionH[index],
                                        descriptionB[index],
                                        descriptionT[index],
                                        descriptionL[index],
                                      ],
                                      edit: true,
                                      image: image[index],
                                      priceList: priceList,
                                      sid: sId[index],
                                    )));
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.deepOrange,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Pakka? Kardu delete??"),
                                        actions: [
                                          TextButton(
                                            child: Text("Karde"),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .doc(
                                                      "inventories/listed_samagri")
                                                  .update({
                                                "samagri":
                                                    FieldValue.arrayRemove(
                                                        list[index])
                                              });
                                            },
                                          )
                                        ],
                                      ));
                            },
                          ),
                        ),
                    separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                    itemCount: nameE.length),
              )),
            );
          }),
    );
  }
}
