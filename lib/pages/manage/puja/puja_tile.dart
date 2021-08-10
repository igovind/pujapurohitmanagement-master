import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/second_edit.dart';

import '../panchang_tile.dart';
import 'magic_screen.dart';

class PujaTile extends StatefulWidget {
  final int index;
  final image;
  final name;
  final description;
  final price;
  final duration;
  final pjid;
  final languageCode;
  final uid;
  final keyword;
  final type;
  final mainSamagriList;
  final List<dynamic> types;
  final List<dynamic> stateList;
  final List<dynamic>? samagri;
  final Map<dynamic, dynamic> initialDetails;

  const PujaTile(
      {Key? key,
      this.image,
      this.name,
      this.description,
      this.price,
      this.duration,
      this.pjid,
      this.samagri,
      this.mainSamagriList,
      this.languageCode,
      this.uid,
      this.keyword,
      this.type,
      required this.types,
      required this.stateList,
      required this.initialDetails,
      required this.index})
      : super(key: key);

  @override
  _PujaTileState createState() => _PujaTileState();
}

class _PujaTileState extends State<PujaTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height(double h) =>
        MagicScreen(height: h, context: context).getHeight;
    return Container(
      // height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        //HexColor("#F9F9D7"),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 3)],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .doc("inventories/listed_puja")
                                        .update({
                                      "listed_puja": FieldValue.arrayRemove(
                                          [widget.initialDetails])
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("YES")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("NO"))
                            ],
                            content: Text(
                                "Are you sure that you want to delete this puja?"),
                            title: Text("DELETE THIS PUJA"),
                          ));
                },
                icon: Icon(Icons.delete)),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text("Index ${widget.index + 1}")),
          Image.network(
            widget.image,
            height: height(150),
          ),
          Text(
            "${widget.name}",
            style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: height(20)),
          ),
          Text(
            "${widget.description}",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height(20),
          ),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      Language(text: [
                        "Price",
                        "मूल्य",
                        "দাম",
                        "மதிப்பு",
                        "విలువ"
                      ], code: widget.languageCode)
                          .getText,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.price}₹",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      Language(text: [
                        "Duration",
                        "समयांतराल",
                        "সময়কাল ",
                        "காலம்",
                        "వ్యవధి"
                      ], code: widget.languageCode)
                          .getText,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.duration}",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height(10),
          ),
          Text("ID ${widget.pjid}"),
          SizedBox(
            height: height(10),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PujaEditFormK(
                      samagriList: widget.mainSamagriList,
                      stateList: widget.stateList,
                      types: widget.types,
                      initialDetails: widget.initialDetails,
                      languageCode: "HIN",
                    ))),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 2)
                    ]),
                child: Text(
                  Language(text: [
                    "Edit",
                    "इस पूजा को जोड़ें",
                    "এই পূজা যোগ করুন",
                    "இந்த பூஜையைச் சேர்க்கவும்",
                    "ఈ పూజను జోడించండి"
                  ], code: widget.languageCode)
                      .getText,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: height(10),
          ),
        ],
      ),
    );
  }
}
