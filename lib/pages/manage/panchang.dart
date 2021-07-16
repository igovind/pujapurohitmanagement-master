import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/panchang_tile.dart';

class PanchangUpdate extends StatefulWidget {
  final count;
  final lang0;
  final lang1;
  final lang2;
  final lang3;
  final lang4;
  final date;

  const PanchangUpdate(
      {Key? key,
      this.count,
      this.lang0,
      this.lang1,
      this.lang2,
      this.lang3,
      this.lang4,
      this.date})
      : super(key: key);

  @override
  _PanchangUpdateState createState() => _PanchangUpdateState();
}

class _PanchangUpdateState extends State<PanchangUpdate> {
  final _nFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String aLang0 = widget.lang0;
    String aLang1 = widget.lang0;
    String aLang2 = widget.lang0;
    String aLang3 = widget.lang0;
    String aLang4 = widget.lang0;
    DateTime aDate = widget.date.toDate();
    DateTime newDate = DateTime(aDate.year, aDate.month, aDate.day + 1);
    return Scaffold(
      // appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_nFormKey.currentState!.validate()) {
            _nFormKey.currentState?.save();
            if (aLang0 == "") {
              print("NEW FIELD IS GENERATING $aLang0");
              FirebaseFirestore.instance.doc("inventories/panchang").update({
                "${widget.count + 1}": {
                  "date": newDate,
                  "more": " ",
                  // "id":"${DateTime.now().}",
                  "panchang": FieldValue.arrayUnion(
                      [aLang0, aLang1, aLang2, aLang3, aLang4])
                },
                "count": FieldValue.increment(1)
              }).whenComplete(() => Navigator.of(context).pop());
            } else {
              print("FIELD IS UPDATING");
              FirebaseFirestore.instance.doc("inventories/panchang").update({
                "${widget.count}": {
                  "date": newDate,
                  "more": " ",
                  "panchang": FieldValue.arrayUnion(
                      [aLang0, aLang1, aLang2, aLang3, aLang4])
                },
              }).whenComplete(() => Navigator.of(context).pop());
            }
          }
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
                        initialValue: widget.lang0,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        decoration: InputDecoration(
                          labelText: "English",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => aLang0 = value!,
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
                        initialValue: widget.lang1,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Hindi",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => aLang1 = value!,
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
                        initialValue: widget.lang2,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Bengali",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => aLang2 = value!,
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
                        initialValue: widget.lang3,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Tamil",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => aLang3 = value!,
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
                        initialValue: widget.lang4,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Telgu",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => aLang4 = value!,
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
          int count = snapshot.data?.get("count");
          Map<dynamic, dynamic> data = {}; //snapshot.data?.get("1");
          Map<dynamic, dynamic> tData;
          List<List<dynamic>> panchang = [];
          List<dynamic> dates = [];
          for (int i = 1; i <= count; i++) {
            data.addAll(snapshot.data?.get("$i"));
            tData = snapshot.data?.get("$i");
            panchang.add(tData["panchang"]);
            dates.add(tData["date"]);
          }
          //  print(panchang);
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PanchangUpdate(
                          count: count + 1,
                          date: dates[count - 1],
                          lang0: "",
                          lang1: "",
                          lang2: "",
                          lang3: "",
                          lang4: "",
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
                  itemCount: count,
                  itemBuilder: (context, index) {
                    String text = panchang[count - index - 1][1];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PanchangUpdate(
                                  count: count - index - 1,
                                  date: dates[count - index - 1],
                                  lang0: panchang[count - index - 1][0],
                                  lang1: panchang[count - index - 1][1],
                                  lang2: panchang[count - index - 1][2],
                                  lang3: panchang[count - index - 1][3],
                                  lang4: panchang[count - index - 1][4],
                                )));
                      },
                      child: PanchangTile(
                        date: dates[count - index - 1],
                        text: text,
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
