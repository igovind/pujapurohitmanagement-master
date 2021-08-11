import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/new_custom_multiple_search.dart';
import 'package:pujapurohitmanagement/pages/manage/puja_form.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_form.dart';

class SamagriPage extends StatefulWidget {
  @override
  _SamagriPageState createState() => _SamagriPageState();
}

class _SamagriPageState extends State<SamagriPage> {
  List<DropdownMenuItem> samagriItems = [];
  bool sidby = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .doc("inventories/listed_puja")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<dynamic> list = snapshot.data!.get("listed_samagri");
          list.sort((b, a) => (a["sid"][0]).compareTo(b["sid"][0]));

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
          List<dynamic> avgPrice = [];
          List<dynamic> commission = [];
          List<dynamic> sId = [];
          List<dynamic> np = [];
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
            avgPrice.add(list[i]["avg_price"]);
            priceList.addAll(list[i]["price"]);
            commission.add(list[i]["commission"]);
            sId.add(list[i]["sid"]);
            np.add(list[i]["np"]);
            samagriItems.add(DropdownMenuItem(
              child: ListTile(
                title: Text("${list[i]["name"][0]}"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${list[i]["sid"]}",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("${list[i]["description"][0]}")
                  ],
                ),
                leading: Image.network("${list[i]["image"]}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SamagriForm(
                            mainList: snapshot.data!.get("listed_samagri")[i],
                            name: [
                              list[i]["name"][0],
                              list[i]["name"][1],
                              list[i]["name"][2],
                              list[i]["name"][3],
                              list[i]["name"][4],
                            ],
                            nonPurchasable: list[i]["np"],
                            description: [
                              list[i]["description"][0],
                              list[i]["description"][1],
                              list[i]["description"][2],
                              list[i]["description"][3],
                              list[i]["description"][4],
                            ],
                            commission: list[i]["commission"],
                            avgPrice: list[i]["avg_price"],
                            edit: true,
                            image: list[i]["image"],
                            priceList: priceList,
                            sid: list[i]["sid"],
                          )));
                },
              ),
              value: sidby ? list[i]["sid"] : list[i]["name"][0],
            ));
          }

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
                            avgPrice: "",
                            priceList: {},
                            commission: "",
                            nonPurchasable: false,
                            sid: "",
                            mainList: {},
                          )));
                },
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          sidby = !sidby;
                        });
                      },
                      child: Text(sidby ? "Search By name" : "Search by SID")),
                  Text("Total ${list.length}"),
                  Container(
                    height: 50,
                    width: 50,
                    child: NewSearchChoices.single(
                      isExpanded: true,
                      displayClearIcon: false,
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {});
                      },
                      autofocus: false,
                      items: samagriItems,
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.blueAccent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black54, blurRadius: 5)
                              ]),
                          child: ListTile(
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
                                Text("${descriptionE[index]}"),
                                Text("${index + 1}")
                              ],
                            ),
                            leading: Image.network("${image[index]}"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SamagriForm(
                                        mainList: snapshot.data!
                                            .get("listed_samagri")[index],
                                        name: [
                                          nameE[index],
                                          nameH[index],
                                          nameB[index],
                                          nameT[index],
                                          nameL[index],
                                        ],
                                        nonPurchasable: np[index],
                                        description: [
                                          descriptionE[index],
                                          descriptionH[index],
                                          descriptionB[index],
                                          descriptionT[index],
                                          descriptionL[index],
                                        ],
                                        commission: commission[index],
                                        avgPrice: avgPrice[index],
                                        edit: true,
                                        image: image[index],
                                        priceList: priceList,
                                        sid: sId[index],
                                      )));
                            },
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 50,
                        ),
                    itemCount: nameE.length),
              ));
        });
  }
}
