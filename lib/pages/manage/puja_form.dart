import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pujapurohitmanagement/pages/manage/custom_searchable_dropdown.dart';
import 'package:pujapurohitmanagement/pages/manage/samagri_form.dart';

class PujaForm extends StatefulWidget {
  final List<String>? name;
  final List<String>? description;
  final List<Map<String, Map<String, int>>>? prices;
  final String? image;
  final bool? edit;
  final String? sid;
  final String? duration;
  final Map<String, dynamic>? priceList;

  const PujaForm(
      {Key? key,
      this.name,
      this.description,
      this.prices,
      this.image,
      this.edit,
      this.sid,
      this.priceList,
      this.duration})
      : super(key: key);

  @override
  _PujaFormState createState() => _PujaFormState();
}

class _PujaFormState extends State<PujaForm> {
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
  String? _image;
  String? _duration;
  int samagriCount = 1;
  List<dynamic> sId = [];
  bool inProcess = false;
  bool loading = false;
  File? userCoverPicFile;
  Map<String, String> quantityList = {};
  final _iFormKey = GlobalKey<FormState>();
  String idA =
      "PJID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
  Map<String, List<String>> samagriK = {};
  List<List<int>> selectedSamagri = List.generate(100, (index) => []);
  List<dynamic> states = [];

  _submit() {
    if (_iFormKey.currentState!.validate()) {
      _iFormKey.currentState!.save();
      if (widget.edit!) {
        FirebaseFirestore.instance.doc("inventories/listed_puja").update({
          "listed_puja": FieldValue.arrayRemove([
            {
              "name": [
                widget.name![0],
                widget.name![1],
                widget.name![2],
                widget.name![3],
                widget.name![4]
              ],
              "description": [
                widget.description![0],
                widget.description![1],
                widget.description![2],
                widget.description![3],
                widget.description![4],
              ],
              "image": widget.image,
              "pjid": widget.sid,
              "avgDuration": widget.duration,
              "samagri": widget.priceList,
            }
          ])
        }).whenComplete(() {
          Map<String, List<String>> samList = {};

          for (int i = 0; i < states.length; i++) {
            List<String> values = [];
            for (int j = 0; j < selectedSamagri[i].length; j++) {
              values.add(sId[selectedSamagri[i][j]]);
            }
            samList.addAll({"${states[i]}": values});
          }
          print("Hamsafar $samList");
          FirebaseFirestore.instance.doc("inventories/listed_puja").update({
            "listed_puja": FieldValue.arrayUnion([
              {
                "name": [
                  _nameE,
                  _nameH,
                  _nameB,
                  _nameT,
                  _nameL,
                ],
                "description": [
                  _descriptionE,
                  _descriptionH,
                  _descriptionB,
                  _descriptionT,
                  _descriptionL,
                ],
                "image": _image,
                "pjid": widget.sid,
                "avgDuration": _duration,
                "samagri": samList,
              }
            ])
          });
        }).whenComplete(() => Navigator.of(context).pop());
      } else {
        Map<String, List<Map<String, String>>> samList = {};

        for (int i = 0; i < states.length; i++) {
          List<Map<String, String>> values = [];
          for (int j = 0; j < selectedSamagri[i].length; j++) {
            values.add({
              "id": sId[selectedSamagri[i][j]],
              "quantity": "${quantityList["${sId[selectedSamagri[i][j]]}"]}",
            });
          }
          samList.addAll({"${states[i]}": values});
        }
        print("Hamsafar $samList");
        FirebaseFirestore.instance.doc("inventories/listed_puja").update({
          "listed_puja": FieldValue.arrayUnion([
            {
              "name": [_nameE, _nameH, _nameB, _nameT, _nameL],
              "description": [
                _descriptionE,
                _descriptionH,
                _descriptionB,
                _descriptionT,
                _descriptionL
              ],
              "image": _image,
              "pjid": idA,
              "avgDuration": _duration,
              "samagri": samList
            }
          ])
        }).whenComplete(() => Navigator.of(context).pop());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButton:
          FloatingActionButton(child: Text("Save"), onPressed: () => _submit()),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _iFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                                            Navigator.of(context).pop();
                                            FirebaseFirestore.instance
                                                .doc("inventories/listed_puja")
                                                .update({
                                              "listed_puja":
                                                  FieldValue.arrayRemove([
                                                {
                                                  "name": [
                                                    widget.name![0],
                                                    widget.name![1],
                                                    widget.name![2],
                                                    widget.name![3],
                                                    widget.name![4]
                                                  ],
                                                  "description": [
                                                    widget.description![0],
                                                    widget.description![1],
                                                    widget.description![2],
                                                    widget.description![3],
                                                    widget.description![4],
                                                  ],
                                                  "image": widget.image,
                                                  "pjid": widget.sid,
                                                  "avgDuration":
                                                      widget.duration,
                                                  "samagri": widget.priceList,
                                                }
                                              ])
                                            });
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
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 4)
                    ]),
                    child: Column(
                      children: [
                        Text(
                          "Name of the Puja",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.name![0],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "English",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _nameE = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.name![1],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Hindi",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _nameH = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.name![2],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Bengali",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _nameB = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.name![3],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Tamil",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _nameT = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.name![4],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Telgu",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _nameL = value!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 4)
                    ]),
                    child: Column(
                      children: [
                        Text(
                          "Description of the Puja",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.description![0],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "English",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _descriptionE = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.description![1],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Hindi",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _descriptionH = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.description![2],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Bengali",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _descriptionB = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.description![3],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Tamil",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _descriptionT = value!,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.description![4],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Telgu",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _descriptionL = value!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  /*Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            this.setState(() {
                              inProcess = true;
                            });
                            // ignore: invalid_use_of_visible_for_testing_member
                            PickedFile? image = await ImagePicker.platform
                                .pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              */ /*    File? cropped = await ImageCropper.cropImage(
                              sourcePath: image.path,
                              aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
                              compressQuality: 100,
                              maxWidth: 700,
                              maxHeight: 700,
                              compressFormat: ImageCompressFormat.jpg,
                            );
*/ /*
                              this.setState(() {
                                userCoverPicFile = File(image.path);
                                inProcess = false;
                              });
                              print("New Storage Image: $userCoverPicFile");
                              */ /*Reference reference = FirebaseStorage.instance
                                  .ref()
                                  .child('listed_puja/pic');
                              UploadTask uploadTask = reference.putFile(userCoverPicFile!);
                              var downloadUrl = await (await uploadTask).ref.getDownloadURL();
                              var url = downloadUrl.toString();
                              _image = url;
                              print("Image: $_image");*/ /*

                            } else {
                              this.setState(() {
                                inProcess = false;
                              });
                            }
                          },
                          child: Container(
                              color: Colors.green,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Select Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      TextButton(
                          onPressed: () async {
                            print("QWEEIENIN");
                            Reference reference = FirebaseStorage.instance
                                .ref()
                                .child('listed_puja/$idA');
                            UploadTask uploadTask =
                                reference.putFile(userCoverPicFile!);
                            var downloadUrl =
                                await (await uploadTask).ref.getDownloadURL();
                            var url = downloadUrl.toString();
                            _image = url;
                            print("Image: $_image");
                          },
                          child: Container(
                              color: Colors.yellow,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Upload Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),*/
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 4)
                    ]),
                    child: Column(
                      children: [
                        Text(
                          "High Quality Image of the Puja",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.image,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Insert Link Here",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _image = value!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 4)
                    ]),
                    child: Column(
                      children: [
                        Text(
                          " Average Duration of puja",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Huh Fill this idiot",
                          initialValue: widget.duration,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "In hours",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) => _duration = value!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  /* widget.edit!
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.4,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black54, blurRadius: 4)
                              ]),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .doc("inventories/listed_samagri")
                                  .snapshots(),
                              builder: (context, snapshotK) {
                                if (snapshotK.data == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                List<dynamic> list =
                                    snapshotK.data!.get("samagri");
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

                                List<DropdownMenuItem> items = [];
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
                                  items.add(DropdownMenuItem(
                                    value: "${list[i]["name"][0]}",
                                    child: ListTile(
                                      title: Text(
                                        "${list[i]["name"][0]}",
                                      ),
                                      leading:
                                          Image.network("${list[i]["image"]}"),
                                      subtitle: Text(
                                        "${list[i]["sid"]}",
                                        style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //value: ,
                                  ));
                                }
                                */ /*for(int k=0;k<states.length;k++){
                                  for(int j=0;j<sId.length;j++){
                                    int pos=sId.contains(widget.priceList[]);
                                    selectedSamagri[k][]
                                  }

                                }*/ /*
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .doc("inventories/state")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      states = snapshot.data!.get("states");

                                      return ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      style: BorderStyle.solid,
                                                      width: 2)),
                                              child: Column(
                                                children: [
                                                  Text("${states[index]}"),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: SearchChoices
                                                          .multiple(
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_drop_down_circle_outlined,
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                        ),
                                                        underline: SizedBox(),
                                                        label: "Select Samagri",
                                                        items: items,
                                                        isExpanded: true,
                                                        displayClearIcon: false,
                                                        onChanged: (value) {
                                                          if (index == 0) {
                                                            setState(() {
                                                              for (int k = 0;
                                                                  k < 100;
                                                                  k++) {
                                                                selectedSamagri[
                                                                    k] = value;
                                                              }
                                                            });
                                                          } else {
                                                            setState(() {
                                                              selectedSamagri[
                                                                      index] =
                                                                  value;
                                                            });
                                                          }
                                                          print(
                                                              "${selectedSamagri[0]}");
                                                        },
                                                        closeButton:
                                                            (selectedItems) {
                                                          return (selectedItems
                                                                  .isNotEmpty
                                                              ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                                              : "Save without selection");
                                                        },
                                                        selectedItems:
                                                            selectedSamagri[
                                                                index],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 10,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: states.length,
                                      );
                                    });
                              }),
                        )
                      :*/
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 4)
                    ]),
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .doc("inventories/listed_samagri")
                            .snapshots(),
                        builder: (context, snapshotK) {
                          if (snapshotK.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<dynamic> list = snapshotK.data!.get("samagri");
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

                          List<DropdownMenuItem> items = [];
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
                            items.add(DropdownMenuItem(
                              value: "${list[i]["name"][0]}",
                              child: ListTile(
                                  title: Text(
                                    "${list[i]["name"][0]}",
                                  ),
                                  leading: Image.network("${list[i]["image"]}"),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                        "${list[i]["sid"]}",
                                        style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                                style: BorderStyle.solid)),
                                        child: TextFormField(
                                          initialValue:
                                              quantityList["${list[i]["sid"]}"],
                                          decoration: InputDecoration(
                                              labelText: "Quantity"),
                                          onChanged: (value) {
                                            setState(() {
                                              quantityList.addAll({
                                                "${list[i]["sid"]}": "$value"
                                              });
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                              //value: ,
                            ));
                          }
                          return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .doc("inventories/state")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                states = snapshot.data!.get("states");

                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 2)),
                                        child: Column(
                                          children: [
                                            Text("${states[index]}"),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30,
                                              child: SingleChildScrollView(
                                                child: SearchChoices.multiple(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_drop_down_circle_outlined,
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                  ),
                                                  underline: SizedBox(),
                                                  label: "Select Samagri",
                                                  items: items,
                                                  isExpanded: true,
                                                  displayClearIcon: false,
                                                  onChanged: (value) {
                                                    if (index == 0) {
                                                      setState(() {
                                                        for (int k = 0;
                                                            k < 100;
                                                            k++) {
                                                          selectedSamagri[k] =
                                                              value;
                                                        }
                                                      });
                                                    } else {
                                                      setState(() {
                                                        selectedSamagri[index] =
                                                            value;
                                                      });
                                                    }
                                                    print(
                                                        "${selectedSamagri[0]}");
                                                  },
                                                  closeButton: (selectedItems) {
                                                    return (selectedItems
                                                            .isNotEmpty
                                                        ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                                        : "Save without selection");
                                                  },
                                                  selectedItems:
                                                      selectedSamagri[index],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 10,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: states.length,
                                );
                              });
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SamagriForm(
                                    edit: false,
                                    description: ["", "", "", "", ""],
                                    name: ["", "", "", "", ""],
                                    image: "",
                                    priceList: {},
                                    sid: "",
                                  ))),
                      child: Container(
                          color: Colors.green,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Add Not Listed Samagri",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
