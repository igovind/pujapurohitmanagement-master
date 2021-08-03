import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/panchang_tile.dart';

class PanchangUpdate extends StatefulWidget {
  final Map<dynamic, dynamic> value;
  final bool edit;
  final DateTime lastDate;

  const PanchangUpdate(
      {Key? key,
      required this.value,
      required this.edit,
      required this.lastDate})
      : super(key: key);

  @override
  _PanchangUpdateState createState() => _PanchangUpdateState();
}

class _PanchangUpdateState extends State<PanchangUpdate> {
  final _nFormKey = GlobalKey<FormState>();
  String? langE;
  String? langH;
  String? langB;
  String? langT;
  String? langTL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_nFormKey.currentState!.validate()) {
            _nFormKey.currentState?.save();
            print("${[langB, langE, langH, langT, langTL]}");
            if (widget.edit) {
              FirebaseFirestore.instance.doc("inventories/panchang").update({
                "dailyPanchang": FieldValue.arrayRemove([widget.value])
              }).whenComplete(() {
                FirebaseFirestore.instance.doc("inventories/panchang").update({
                  "dailyPanchang": FieldValue.arrayUnion([
                    {
                      "date": widget.value["date"],
                      "panchang": [langE, langH, langB, langT, langTL]
                    }
                  ])
                });
              });
            } else {
              FirebaseFirestore.instance.doc("inventories/panchang").update({
                "dailyPanchang": FieldValue.arrayUnion([
                  {
                    "date": widget.lastDate.add(Duration(days: 1)),
                    "panchang": [langE, langH, langB, langT, langTL]
                  }
                ])
              });
            }
          }
          Navigator.of(context).pop();
        },
        child: Icon(Icons.check),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _nFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // width: 400,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(16),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        initialValue:
                            widget.edit ? widget.value["panchang"][0] : "",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        decoration: InputDecoration(
                          labelText: "English",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => langE = value!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      //width: 400,
                      padding: EdgeInsets.all(16),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        initialValue:
                            widget.edit ? widget.value["panchang"][1] : "",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Hindi",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => langH = value!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      //width: 400,
                      padding: EdgeInsets.all(16),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        initialValue:
                            widget.edit ? widget.value["panchang"][2] : "",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Bengali",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => langB = value!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      //width: 400,
                      padding: EdgeInsets.all(16),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        initialValue:
                            widget.edit ? widget.value["panchang"][3] : "",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Tamil",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => langT = value!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      //width: 400,
                      padding: EdgeInsets.all(16),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        initialValue:
                            widget.edit ? widget.value["panchang"][4] : "",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Telugu",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => langTL = value!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class PanchangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.doc('inventories/panchang').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<dynamic> listOfPanchang = snapshot.data!.get("dailyPanchang");
          listOfPanchang.sort((a, b) => (b["date"]).compareTo(a["date"]));
         // print("Last Date: ${lis}")
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PanchangUpdate(
                          value: {"": ""},
                          edit: false,
                          lastDate: listOfPanchang.first["date"].toDate(),
                        )));
              },
              child: Icon(Icons.add),
            ),
            body: Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                  itemCount: listOfPanchang.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PanchangUpdate(
                                  lastDate: DateTime.now(),
                                  edit: true,
                                  value: listOfPanchang[index],
                                )));
                      },
                      child: PanchangTile(
                        date: listOfPanchang[index]["date"],
                        text: listOfPanchang[index]["panchang"],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
