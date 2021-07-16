import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SamagriForm extends StatefulWidget {
  final List<String>? name;
  final List<String>? description;
  final List<Map<String, Map<String, int>>>? prices;
  final String? image;
  final bool? edit;
  final String? sid;
  final Map<String, dynamic>? priceList;

  const SamagriForm(
      {Key? key,
      this.name,
      this.description,
      this.prices,
      this.image,
      this.edit,
      this.sid,
      this.priceList})
      : super(key: key);

  @override
  _SamagriFormState createState() => _SamagriFormState();
}

class _SamagriFormState extends State<SamagriForm> {
  String? _nameH;
  String? _nameE;
  String? _nameB;
  String? _nameT;
  String? _nameL;
  String? _descriptionH;
  String? _descriptionE;
  String? _descriptionB;
  String? _descriptionT;
  String? _descriptionL;

  final _kFormKey = GlobalKey<FormState>();
  String? _image;
  List<Map<String, Map<String, int>>>? _prices;

  _submit(List<dynamic> states) {
    if (_kFormKey.currentState!.validate()) {
      _kFormKey.currentState!.save();
      Map<String, Map<String, int>> list = {};
      for (int i = 0; i < states.length; i++) {
        list.addAll({
          "${states[i]}": {"d": 0}
        });
      }

      // print("$priceValue");
      if (widget.edit!) {
        FirebaseFirestore.instance.doc("inventories/listed_samagri").update({
          "samagri": FieldValue.arrayRemove([
            {
              "name": [
                widget.name![0],
                widget.name![1],
                widget.name![2],
                widget.name![3],
                widget.name![4],
              ],
              "description": [
                widget.description![0],
                widget.description![1],
                widget.description![2],
                widget.description![3],
                widget.description![4]
              ],
              "sid": widget.sid,
              "image": widget.image,
              "price": widget.priceList,
            }
          ])
        }).whenComplete(() {
          FirebaseFirestore.instance.doc("inventories/listed_samagri").update({
            "samagri": FieldValue.arrayUnion([
              {
                "name": [_nameE, _nameH, _nameB, _nameT, _nameL],
                "description": [
                  _descriptionE,
                  _descriptionH,
                  _descriptionB,
                  _descriptionT,
                  _descriptionL
                ],
                "sid": widget.sid,
                "image": _image,
                "price": widget.priceList,
              }
            ])
          });
        }).whenComplete(() => Navigator.of(context).pop());
      } else {
        FirebaseFirestore.instance.doc("inventories/listed_samagri").update({
          "samagri": FieldValue.arrayUnion([
            {
              "name": [_nameE, _nameH, _nameB, _nameT, _nameL],
              "description": [
                _descriptionE,
                _descriptionH,
                _descriptionB,
                _descriptionT,
                _descriptionL
              ],
              "sid":
                  "SID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
              "image": _image,
              "price": list,
            }
          ])
        }).whenComplete(() => Navigator.of(context).pop());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc("inventories/state").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Text("Save"),
              onPressed: () => _submit(snapshot.data!.get("states")),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _kFormKey,
                child: Container(
                  padding: EdgeInsets.all(50),
                  color: Colors.green,
                  child: Column(
                    children: [
                      !widget.edit!
                          ? SizedBox()
                          : TextButton(
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
                                                      FieldValue.arrayRemove([
                                                    {
                                                      "name": [
                                                        widget.name![0],
                                                        widget.name![1],
                                                        widget.name![2],
                                                        widget.name![3],
                                                        widget.name![4],
                                                      ],
                                                      "description": [
                                                        widget.description![0],
                                                        widget.description![1],
                                                        widget.description![2],
                                                        widget.description![3],
                                                        widget.description![4]
                                                      ],
                                                      "sid": widget.sid,
                                                      "image": widget.image,
                                                      "price": widget.priceList,
                                                    }
                                                  ])
                                                }).whenComplete(() =>
                                                        Navigator.of(context)
                                                            .pop());
                                              },
                                            )
                                          ],
                                        ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(14),
                                color: Colors.redAccent,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black54, blurRadius: 4)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Name of Samagri",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.name![0],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "English",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _nameE = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.name![1],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Hindi",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _nameH = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.name![2],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Bengali",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _nameB = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.name![3],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Tamil",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _nameT = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.name![4],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Telgu",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _nameL = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      space,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black54, blurRadius: 4)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Description of Samagri",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.description![0],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "English",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _descriptionE = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.description![1],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Hindi",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _descriptionH = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.description![2],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Bengali",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _descriptionB = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.description![3],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Tamil",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _descriptionT = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.description![4],
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Telgu",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _descriptionL = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      space,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black54, blurRadius: 4)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "High Quality Image",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextFormField(
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : "Huh Fill this idiot",
                              initialValue: widget.image,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Link",
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _image = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      space,
                      /*Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 4)]),
                      child: Column(
                        children: [
                          Text(
                            "Avg Price",
                            style: TextStyle(color: Colors.black54),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .doc("inventories/state")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                List<dynamic> states = snapshot.data?.get("states");
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => TextFormField(
                                            validator: (value) =>
                                                value!.isNotEmpty || value is int
                                                    ? null
                                                    : "Huh Fill this Correctly idiot",
                                            //  initialValue: widget.lang3,
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              labelText: "${states[index]}",
                                              border: InputBorder.none,
                                            ),
                                            // onSaved: (value) => aLang3 = value!,
                                          ),
                                      separatorBuilder: (context, index) => SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: 28),
                                );
                              })
                        ],
                      ),
                    ),*/
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget get space => SizedBox(
      height: 50,
    );
