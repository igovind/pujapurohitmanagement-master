import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/reusable_widgets.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/magic_screen.dart';

class PurohitUidaiDetails extends StatefulWidget {
  final uid;

  const PurohitUidaiDetails(
      {Key? key,  this.uid})
      : super(key: key);

  @override
  State<PurohitUidaiDetails> createState() => _PurohitUidaiDetailsState();
}

class _PurohitUidaiDetailsState extends State<PurohitUidaiDetails> {
  final _tMformKey = GlobalKey<FormState>();
  String netUrlFront =
      "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg";
  String netUrlBack =
      "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg";
  String uidaiNum = "";
  String name = "";
  String address = "";

  @override


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${widget.uid}/pandit_credentials/pandit_uidai_details').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
          netUrlFront =
          snapshot.data!.get("pandit_uidai_front_pic") == null
              ? ""
              : snapshot.data!.get("pandit_uidai_front_pic");
          netUrlBack =
          snapshot.data!.get("pandit_uidai_back_pic") == null
              ? ""
              : netUrlBack =
              snapshot.data!.get("pandit_uidai_back_pic");
          address =
          snapshot.data!.get("pandit_uidai_address") == null
              ? ""
              : address =
              snapshot.data!.get("pandit_uidai_address");
          name = snapshot.data!.get("pandit_uidai_name") == null
              ? ""
              : name = snapshot.data!.get("pandit_uidai_name");
          uidaiNum =
          snapshot.data!.get("pandit_uidai_number") == null
              ? ""
              : uidaiNum =
              snapshot.data!.get("pandit_uidai_number");

        return Scaffold(
          body: Center(
            child: Form(
              key: _tMformKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Front Pic"),
                      CustomImageUploader(
                          imageHeight:
                              MagicScreen(height: 600, context: context).getHeight,
                          imageWidth:
                              MagicScreen(width: 350, context: context).getWidth,
                          networkImageUrl: netUrlFront,
                          path: 'Users/${widget.uid}/frontAdhaar',
                          onPressed: (String string) {
                            netUrlFront = string;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Back Pic"),
                      CustomImageUploader(
                          imageHeight:
                              MagicScreen(height: 600, context: context).getHeight,
                          imageWidth:
                              MagicScreen(width: 350, context: context).getWidth,
                          networkImageUrl: netUrlBack,
                          path: 'Users/${widget.uid}/backAdhaar',
                          onPressed: (String? string) {
                            netUrlBack = string!;
                          }),
                      CustomTextFormField(
                          lable: "Name On Adhaar",
                          initialText: name,
                          onPress: (String? string) {
                            name = string!;
                          }),
                      CustomTextFormField(
                          lable: "Adhaar Number",
                          initialText: uidaiNum,
                          onPress: (String? string) {
                            uidaiNum = string!;
                          }),
                      CustomTextFormField(
                          lable: "Address on Adhaar",
                          initialText: address,
                          onPress: (String? string) {
                            address = string!;
                          }),
                      TextButton(
                          onPressed: () {
                            _tMformKey.currentState!.save();
                            FirebaseFirestore.instance
                                .doc(
                                    'users_folder/folder/pandit_users/${widget.uid}/pandit_credentials/pandit_uidai_details')
                                .update({
                              'pandit_uidai_address': address,
                              'pandit_uidai_back_pic': netUrlBack,
                              'pandit_uidai_name': name,
                              'pandit_uidai_front_pic': netUrlFront,
                              'pandit_uidai_number': uidaiNum
                            }).whenComplete(() => Navigator.of(context).pop());
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
