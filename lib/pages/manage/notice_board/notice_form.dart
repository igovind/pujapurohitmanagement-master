import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeForm extends StatefulWidget {
  final dynamic value;

  const NoticeForm({Key? key, this.value}) : super(key: key);

  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  final _rKey = GlobalKey<FormState>();
  String? titleE;
  String? titleH;
  String? titleB;
  String? titleT;
  String? titleTL;
  String? subtitleE;
  String? subtitleH;
  String? subtitleB;
  String? subtitleT;
  String? subtitleTL;
  String? descriptionE;
  String? descriptionH;
  String? descriptionB;
  String? descriptionT;
  String? descriptionTL;
  String? image;
  bool? imp;

  @override
  void initState() {
    // TODO: implement initState
    imp = widget.value==null?false:widget.value["important"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (_rKey.currentState!.validate()) {
                  _rKey.currentState!.save();
                  if (widget.value != null) {
                    FirebaseFirestore.instance
                        .doc("inventories/tab_bar_icons")
                        .update({
                      "notice_board": FieldValue.arrayRemove([widget.value])
                    });
                    FirebaseFirestore.instance
                        .doc("inventories/tab_bar_icons")
                        .update({
                      "notice_board": FieldValue.arrayUnion([
                        {
                          "title": [titleE, titleH, titleB, titleT, titleTL],
                          "subtitle": [
                            subtitleE,
                            subtitleH,
                            subtitleB,
                            subtitleT,
                            subtitleTL
                          ],
                          "description": [
                            descriptionE,
                            descriptionH,
                            descriptionB,
                            descriptionT,
                            descriptionTL
                          ],
                          "date": widget.value["date"],
                          "important": imp,
                          "image": image,
                        }
                      ])
                    });
                  } else {
                    FirebaseFirestore.instance
                        .doc("inventories/tab_bar_icons")
                        .update({
                      "notice_board": FieldValue.arrayUnion([
                        {
                          "title": [titleE, titleH, titleB, titleT, titleTL],
                          "subtitle": [
                            subtitleE,
                            subtitleH,
                            subtitleB,
                            subtitleT,
                            subtitleTL
                          ],
                          "description": [
                            descriptionE,
                            descriptionH,
                            descriptionB,
                            descriptionT,
                            descriptionTL
                          ],
                          "date": DateTime.now(),
                          "important": imp,
                          "image": image,
                        }
                      ])
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _rKey,
        child: Column(
          children: [
            Text("Title"),
            Container(
              padding: EdgeInsets.all(20),
              // height: 200,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue:
                          widget.value == null ? "" : widget.value["title"][0],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "English",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => titleE = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue:
                          widget.value == null ? "" : widget.value["title"][1],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Hindi",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => titleH = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue:
                          widget.value == null ? "" : widget.value["title"][2],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Bengali",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => titleB = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue:
                          widget.value == null ? "" : widget.value["title"][3],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Tamil",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => titleT = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue:
                          widget.value == null ? "" : widget.value["title"][4],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Telugu",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => titleTL = value!,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Subtitle-->Max 12 words"),
            Container(
              padding: EdgeInsets.all(20),
              // height: 200,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["subtitle"][0],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "English",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => subtitleE = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["subtitle"][1],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Hindi",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => subtitleH = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["subtitle"][2],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Bengali",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => subtitleB = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["subtitle"][3],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Tamil",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => subtitleT = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["subtitle"][4],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Telugu",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => subtitleTL = value!,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Description"),
            Container(
              padding: EdgeInsets.all(20),
              // height: 200,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                      value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["description"][0],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "English",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => descriptionE = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                      value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["description"][1],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Hindi",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => descriptionH = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                      value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["description"][2],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Bengali",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => descriptionB = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                      value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["description"][3],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Tamil",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => descriptionT = value!,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                      value!.isNotEmpty ? null : "Huh Fill this idiot",
                      initialValue: widget.value == null
                          ? ""
                          : widget.value["description"][4],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Telugu",
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => descriptionTL = value!,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width*0.4,
                      child: TextFormField(
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Huh Fill this idiot",
                        initialValue:
                            widget.value == null ? "" : widget.value["image"],
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Image Link",
                          border: InputBorder.none,
                        ),
                        onSaved: (value) => image = value!,
                      ),
                    ),
                    Column(
                      children: [
                        Text("Important?"),
                        Checkbox(
                            value: imp,
                            onChanged: (bool? value) {
                              setState(() {
                                imp = true;
                              });
                            })
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
