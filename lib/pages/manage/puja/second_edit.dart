import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../panchang_tile.dart';
import '../samagri_page.dart';
import 'magic_screen.dart';
import 'new_custom_multiple_search.dart';

class PujaEditFormK extends StatefulWidget {
  final languageCode;
  final List<dynamic> types;
  final List<dynamic> samagriList;
  final List<dynamic> stateList;
  final Map<dynamic, dynamic> initialDetails;

  const PujaEditFormK(
      {Key? key,
      this.languageCode,
      required this.samagriList,
      required this.stateList,
      required this.types,
      required this.initialDetails})
      : super(key: key);

  @override
  _PujaEditFormKState createState() => _PujaEditFormKState();
}

class _PujaEditFormKState extends State<PujaEditFormK> {
  final _aFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem> samagriItems = [];
  List<DropdownMenuItem> typeItems = [];
  Map<String, String> newMap = {};
  Map<dynamic, List<int>> selectedSamagriIndex = {};
  Map<dynamic, dynamic> samagriQuantityMap = {};
  Map<dynamic, dynamic> quantityList = {};
  List<Map<dynamic, dynamic>> selectedSamagriList = [];
  Map<dynamic, List<Map<String, String>>> finalSamagriMap = {};

  bool editSam = false;
  String? _name0;
  String? _name1;
  String? _name2;
  String? _name3;
  String? _name4;

  String? _description0;
  String? _description1;
  String? _description2;
  String? _description3;
  String? _description4;
  String _image = "";
  String? _keyword;
  String? _bg;
  String? _price;
  String? _duration;

  @override
  void initState() {
 /*   widget.stateList.forEach((element) {
      selectedSamagriIndex.addAll({element: []});
    });*/
    List<dynamic> listT = [];
    widget.samagriList.forEach((element) {
      listT.add(element["sid"]);
    });
    widget.stateList.forEach((element) {
      Map<dynamic, dynamic> newOpList = widget.initialDetails["samagri"];
      List<int> listD = [];
      for (int i = 0; i < newOpList[element]!.length; i++) {
        if(listT.contains(newOpList[element][i]["id"])){
          listD.add(listT.indexOf(newOpList[element][i]["id"]));
          newMap.addAll({
            "${newOpList[element][i]["id"]}":
            "${newOpList[element][i]["quantity"]}"
          });
        }
      }

      selectedSamagriIndex.addAll({"$element": listD});
    });
    widget.types.forEach((element) {
      typeItems.add(DropdownMenuItem(
        child: Text("$element"),
        value: element,
      ));
    });
    widget.samagriList.forEach((element) {
      samagriItems.add(DropdownMenuItem(
          value: "${element["name"][0]}",
          child: ListTile(
            trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.deepOrangeAccent,
                      width: 0.5,
                      style: BorderStyle.solid)),
              height: 50,
              width: 40,
              child: TextFormField(
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                maxLength: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  newMap.addAll({"${element["sid"]}": "$value"});
                },
                showCursor: true,
                style: TextStyle(fontSize: 15),
              ),
            ),
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(element["image"]),
                      fit: BoxFit.cover)),
              height: 50,
              width: 50,
            ),
            title: Text("${element["name"][0]}"),
            subtitle: Column(
              children: [
                Text("${element["description"][0]}"),
                Text(
                  "${element["sid"]}",
                  style: TextStyle(color: Colors.deepOrange),
                )
              ],
            ),
          )));
    });
    _image = widget.initialDetails["image"];
    _price = widget.initialDetails["type"];
    for(int i=0;i<selectedSamagriIndex.length;i++){
      print("${selectedSamagriIndex[0]}");
    }
    print("BSDK:: ${selectedSamagriIndex[0]}");
    // print(widget.samagriList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height(double h) =>
        MagicScreen(height: h, context: context).getHeight;
    double width(double h) => MagicScreen(width: h, context: context).getWidth;
    double wid = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                if (_aFormKey.currentState!.validate()) {
                  _aFormKey.currentState!.save();
                  FirebaseFirestore.instance
                      .doc("inventories/listed_puja")
                      .update({
                    "listed_puja":
                    FieldValue.arrayRemove([widget.initialDetails])
                  }).whenComplete(() {
                    selectedSamagriIndex.forEach((key, value) {
                      List<Map<String, String>> tempList = [];
                      for (int s = 0; s < value.length; s++) {
                        tempList.add({
                          "id": "${widget.samagriList[value[s]]["sid"]}",
                          "quantity":
                          "${newMap[widget.samagriList[value[s]]["sid"]]}"
                        });
                      }
                      finalSamagriMap.addAll({"$key": tempList});
                    });
                    print("AMAZINGLY::$finalSamagriMap");
                    FirebaseFirestore.instance
                        .doc("inventories/listed_puja")
                        .update({
                      "listed_puja": FieldValue.arrayUnion([
                        {
                          "name": [_name0, _name1, _name2, _name3, _name4],
                          "description": [
                            _description0,
                            _description1,
                            _description2,
                            _description3,
                            _description4
                          ],
                          "pjid": widget.initialDetails["pjid"],
                          "bg": _bg,
                          "avgDuration": _duration,
                          "keyword": _keyword,
                          "image": _image,
                          "type": _price,
                          "doc": DateTime.now(),
                          "samagri": finalSamagriMap,
                          //FieldValue.arrayUnion(quantityIdMap)
                        }
                      ])
                    });
                  }).whenComplete(() => Navigator.of(context).pop());
                }
              },
              child: Text(
                Language(code: widget.languageCode, text: [
                  "Save ",
                  "पूर्ण ",
                  "সম্পন্ন ",
                  "முடிந்தது ",
                  "పూర్తి "
                ]).getText,
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _aFormKey,
          child: Container(
            // height: 100,
            padding: EdgeInsets.all(10),

            child: Column(
              children: [
                Image.network(
                  _image,
                  height: MagicScreen(context: context, height: height(250))
                      .getHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: TextFormField(
                        initialValue: widget.initialDetails["name"][0],
                        cursorColor: Colors.deepOrange,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Name English",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          setState(() {
                            _name0 = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      width: wid / 4,
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["name"][1],
                        cursorColor: Colors.deepOrange,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Name Hindi",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          setState(() {
                            _name1 = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["name"][2],
                        cursorColor: Colors.deepOrange,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Name Bengali",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          setState(() {
                            _name2 = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["name"][3],
                        cursorColor: Colors.deepOrange,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Name Tamil",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          setState(() {
                            _name3 = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["name"][4],
                        cursorColor: Colors.deepOrange,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Name Telugu",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          setState(() {
                            _name4 = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["description"][0],
                        //textAlign: TextAlign.center,
                        onSaved: (value) {
                          setState(() {
                            _description0 = value;
                          });
                        },
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Description English",
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["description"][1],
                        //textAlign: TextAlign.center,
                        onSaved: (value) {
                          setState(() {
                            _description1 = value;
                          });
                        },
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Description Hindi",
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["description"][2],
                        //textAlign: TextAlign.center,
                        onSaved: (value) {
                          setState(() {
                            _description2 = value;
                          });
                        },
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Description Bengali",
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["description"][3],
                        //textAlign: TextAlign.center,
                        onSaved: (value) {
                          setState(() {
                            _description3 = value;
                          });
                        },
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Description Tamil",
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                      ),
                    ),
                    Container(
                      width: wid / 4,
                      child: TextFormField(
                        initialValue: widget.initialDetails["description"][4],
                        //textAlign: TextAlign.center,
                        onSaved: (value) {
                          setState(() {
                            _description4 = value;
                          });
                        },
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Description Telugu",
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : Language(code: widget.languageCode, text: [
                                "This field is required",
                                "यह फ़ील्ड आवश्यक है",
                                "ঘরটি অবশ্যই পূরণ করতে হবে",
                                "இந்த புலம் தேவை",
                                "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                              ]).getText,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(20),
                ),
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Text(
                                "Type",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            DropdownButtonFormField(
                              value: widget.initialDetails["type"],
                              items: typeItems,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _price = "$value";
                                });
                              },
                            )
                          ],
                        ),
                        height: height(100),
                        width: width(100),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Text(
                                Language(text: [
                                  "Duration",
                                  "समयांतराल",
                                  "সময়কাল ",
                                  "காலம்",
                                  "వ్యవధి"
                                ], code: widget.languageCode)
                                    .getText,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            TextFormField(
                              initialValue:
                                  widget.initialDetails["avgDuration"],
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _duration = value;
                                });
                              },
                              cursorColor: Colors.deepOrange,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              //maxLength: null,
                              showCursor: true,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : Language(code: widget.languageCode, text: [
                                      "This field is required",
                                      "यह फ़ील्ड आवश्यक है",
                                      "ঘরটি অবশ্যই পূরণ করতে হবে",
                                      "இந்த புலம் தேவை",
                                      "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                                    ]).getText,
                            ),
                          ],
                        ),
                        height: height(70),
                        width: width(100),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height(20),
                ),
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Text(
                                "Keyword",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            TextFormField(
                              initialValue: widget.initialDetails["keyword"],
                              autofocus: true,
                              cursorColor: Colors.deepOrange,
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _keyword = value;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              //maxLength: null,
                              showCursor: true,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : Language(code: widget.languageCode, text: [
                                      "This field is required",
                                      "यह फ़ील्ड आवश्यक है",
                                      "ঘরটি অবশ্যই পূরণ করতে হবে",
                                      "இந்த புலம் தேவை",
                                      "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                                    ]).getText,
                            ),
                          ],
                        ),
                        height: height(100),
                        width: width(100),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Text(
                                "Image link",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            TextFormField(
                              initialValue: widget.initialDetails["image"],
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _image = value!;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _image = value;
                                });
                              },
                              cursorColor: Colors.deepOrange,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              //maxLength: null,
                              showCursor: true,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : Language(code: widget.languageCode, text: [
                                      "This field is required",
                                      "यह फ़ील्ड आवश्यक है",
                                      "ঘরটি অবশ্যই পূরণ করতে হবে",
                                      "இந்த புலம் தேவை",
                                      "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                                    ]).getText,
                            ),
                          ],
                        ),
                        height: height(100),
                        width: width(100),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Text(
                                "Background color",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            TextFormField(
                              initialValue: widget.initialDetails["bg"],
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _bg = value!;
                                });
                              },

                              cursorColor: Colors.deepOrange,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              //maxLength: null,
                              showCursor: true,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : Language(code: widget.languageCode, text: [
                                      "This field is required",
                                      "यह फ़ील्ड आवश्यक है",
                                      "ঘরটি অবশ্যই পূরণ করতে হবে",
                                      "இந்த புலம் தேவை",
                                      "ఈ ఖాళీని తప్పనిసరిగా పూరించవలెను"
                                    ]).getText,
                            ),
                          ],
                        ),
                        height: height(100),
                        width: width(100),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height(20),
                ),
                Text(
                  Language(code: widget.languageCode, text: [
                    "Puja samagri ",
                    "पूजा की सामग्री  ",
                    "পূজা উপাদান ",
                    "பூஜை பொருள் ",
                    "పూజా పదార్థం "
                  ]).getText,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height(10),
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    height: height(600),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, indexS) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.grey[200],
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Text(
                                  "${widget.stateList[indexS]}",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Container(
                                  height: height(520),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Language(
                                                code: widget.languageCode,
                                                text: [
                                                  "Samagri ",
                                                  "सामग्री  ",
                                                  "উপাদান ",
                                                  "பொருள் ",
                                                  "పదార్థం "
                                                ]).getText,
                                          ),
                                          Text(Language(
                                              code: widget.languageCode,
                                              text: [
                                                "Quantity ",
                                                "मात्रा  ",
                                                "পরিমাণ ",
                                                "அளவு ",
                                                "పరిమాణం "
                                              ]).getText)
                                        ],
                                      ),
                                      SizedBox(
                                        height: height(10),
                                      ),
                                      //TextButton(onPressed: ()=>print("${selectedSamagriIndex}"), child: Text("Fuck")),
                                      Container(
                                          height: height(450),
                                          child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        height: height(5),
                                                      ),
                                              itemCount: selectedSamagriIndex[widget.stateList[indexS]]!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  color: Colors.grey[100],
                                                  padding: EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "${widget.samagriList[selectedSamagriIndex["${widget.stateList[indexS]}"]![index]]["name"][0]}"),
                                                      Text(
                                                          "${newMap[widget.samagriList[selectedSamagriIndex["${widget.stateList[indexS]}"]![index]]["sid"]]}"),
                                                    ],
                                                  ),
                                                );
                                              })
                                      ),
                                      NewSearchChoices.multiple(
                                        isExpanded: true,
                                        displayClearIcon: false,
                                        underline: SizedBox(),
                                        onChanged: (value) {
                                          setState(() {
                                            if (indexS == 0) {
                                              for (int i = 0;
                                                  i < widget.stateList.length;
                                                  i++) {
                                                selectedSamagriIndex[widget
                                                    .stateList[i]] = value;
                                              }
                                            } else {
                                              selectedSamagriIndex[widget
                                                  .stateList[indexS]] = value;
                                            }
                                          });
                                          print(
                                              "B prak${selectedSamagriIndex}");
                                        },
                                        autofocus: false,
                                        selectedItems: selectedSamagriIndex[
                                            widget.stateList[indexS]]!,
                                        closeButton: (selectedItems) {
                                          return (selectedItems.isNotEmpty
                                              ? "Save ${selectedItems.length == 1 ? '"' + samagriItems[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                              : "Save without selection");
                                        },
                                        items: samagriItems,
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              width: 20,
                            ),
                        itemCount: widget.stateList.length)),
                TextButton(child: Text("Add not Listed Samagri"),onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              SamagriPage()));
                },),
                SizedBox(
                  height: height(200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
