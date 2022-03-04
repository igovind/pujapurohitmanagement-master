import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PanditDataTransfer extends StatelessWidget {
  const PanditDataTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Hello");
    return Scaffold(
      appBar: AppBar(
        title: Text("Database Management UI"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Avaliable_pundit")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return /*ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  color: Colors.grey,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                          "$index--> ${snapshot.data?.docs[index].id}")),
                );
              },
              itemCount: snapshot.data!.size,
            );*/
                Center(
                    child: TextButton(
                        onPressed: () async {
                           for (int i = 0; i < 10; i++) {
                         // int i = 418;
                          print("XXXX Shruti->$i ${snapshot.data!.size}");
                          DocumentSnapshot userData = await FirebaseFirestore
                              .instance
                              .doc(
                                  "punditUsers/${snapshot.data?.docs[i].id}/user_profile/user_data")
                              .get();
                          DocumentSnapshot userAdhar = await FirebaseFirestore
                              .instance
                              .doc(
                                  "punditUsers/${snapshot.data?.docs[i].id}/user_profile/user_adhaar_details")
                              .get();
                          DocumentSnapshot userBank = await FirebaseFirestore
                              .instance
                              .doc(
                                  "punditUsers/${snapshot.data?.docs[i].id}/user_profile/user_bank_details")
                              .get();
                          DocumentSnapshot userGallery = await FirebaseFirestore
                              .instance
                              .doc(
                                  "punditUsers/${snapshot.data?.docs[i].id}/user_profile/galleryPic")
                              .get();

                          FirebaseFirestore.instance
                              .doc(
                                  "users_folder/folder/pandit_users/${snapshot.data?.docs[i].id}")
                              .set({
                            "pandit_name":
                                userData.data()!.containsKey("firstName")
                                    ? userData.data()!["firstName"]
                                    : null,
                            "pandit_bio":
                                userData.data()!.containsKey("aboutYou")
                                    ? userData.data()!["aboutYou"]
                                    : null,
                            "pandit_state":
                                userData.data()!.containsKey("state")
                                    ? userData.data()!["state"]
                                    : null,
                            "pandit_city":
                                userData.data()!.containsKey("lastName")
                                    ? userData.data()!["lastName"]
                                    : null,
                            "pandit_age": 0,
                            "pandit_qualification": null,
                            "pandit_verification_status":
                                userData.data()!.containsKey("verified")
                                    ? userData.data()!["verified"]
                                    : null,
                            "pandit_mobile_number":
                                userData.data()!.containsKey("number")
                                    ? userData.data()!["number"]
                                    : null,
                            "pandit_swastik":
                                userData.data()!.containsKey("swastik")
                                    ? userData.data()!["swastik"]
                                    : null,
                            "pandit_type": userData.data()!.containsKey("type")
                                ? userData.data()!["type"]
                                : null,
                            "pandit_display_profile":
                                userData.data()!.containsKey("profilePicUrl")
                                    ? userData.data()!["profilePicUrl"]
                                    : null,
                            "pandit_cover_profile":
                                userData.data()!.containsKey("coverpic")
                                    ? userData.data()!["coverpic"]
                                    : null,
                            "pandit_id":
                                userData.data()!.containsKey("punditID")
                                    ? userData.data()!["punditID"]
                                    : null,
                            "pandit_joining_date": userData
                                    .data()!
                                    .containsKey("dateOfProfileCreation")
                                ? userData.data()!["dateOfProfileCreation"]
                                : null,
                            "pandit_profile_update_date":
                                userData.data()!["dateOfProfileCreation"],
                            "pandit_token": userData.data()!["token"],
                            "pandit_email": null,
                            "pandit_uid": userData.data()!["uid"],
                            "pandit_language":
                                userData.data()!.containsKey("language")
                                    ? userData.data()!["language"]
                                    : null,
                            "pandit_app_language_code":
                                userData.data()!.containsKey("langCode")
                                    ? userData.data()!["langCode"]
                                    : null,
                            "pandit_location":
                                userData.data()!.containsKey("location")
                                    ? userData.data()!["location"]
                                    : null,
                            "pandit_expertise":
                                userData.data()!.containsKey("expertise")
                                    ? userData.data()!["expertise"]
                                    : null,
                            "pandit_experience":
                                userData.data()!.containsKey("experience")
                                    ? userData.data()!["experience"]
                                    : null,
                            "pandit_pictures": userGallery.exists
                                ? [
                                    userGallery.data()!.containsKey("link1")
                                        ? userGallery.data()!["link1"]
                                        : null,
                                    userGallery.data()!.containsKey("link2")
                                        ? userGallery.data()!["link2"]
                                        : null,
                                    userGallery.data()!.containsKey("link3")
                                        ? userGallery.data()!["link3"]
                                        : null,
                                    userGallery.data()!.containsKey("link4")
                                        ? userGallery.data()!["link4"]
                                        : null
                                  ]
                                : null,
                          });

                          if (userAdhar.exists) {
                            FirebaseFirestore.instance
                                .doc(
                                    "users_folder/folder/pandit_users/${snapshot.data?.docs[i].id}/pandit_credentials/pandit_uidai_details")
                                .set({
                              "pandit_uidai_address":
                                  userAdhar.data()!["address"],
                              "pandit_uidai_number":
                                  userAdhar.data()!["adhaarNumber"],
                              "pandit_uidai_back_pic":
                                  userAdhar.data()!["backAdhaarPicUrl"],
                              "pandit_uidai_front_pic":
                                  userAdhar.data()!["frontAdhaarPicUrl"],
                              "pandit_uidai_name": userAdhar.data()!["name"]
                            });
                          } else {
                            FirebaseFirestore.instance
                                .doc(
                                    "users_folder/folder/pandit_users/${snapshot.data?.docs[i].id}/pandit_credentials/pandit_uidai_details")
                                .set({
                              "pandit_uidai_address": null,
                              "pandit_uidai_number": null,
                              "pandit_uidai_back_pic": null,
                              "pandit_uidai_front_pic": null,
                              "pandit_uidai_name": null
                            });
                          }
                          if (userBank.exists) {
                            FirebaseFirestore.instance
                                .doc(
                                    "users_folder/folder/pandit_users/${snapshot.data?.docs[i].id}/pandit_credentials/pandit_bank_details")
                                .set({
                              "pandit_bank_name": userBank.data()!["bankName"],
                              "pandit_name_on_bank": userBank.data()!["name"],
                              "pandit_bank_account_number":
                                  userBank.data()!["accountNumber"],
                              "pandit_bank_ifsc_code": userBank.data()!["IFSC"]
                            });
                          } else {
                            FirebaseFirestore.instance
                                .doc(
                                    "users_folder/folder/pandit_users/${snapshot.data?.docs[i].id}/pandit_credentials/pandit_bank_details")
                                .set({
                              "pandit_bank_name": null,
                              "pandit_name_on_bank": null,
                              "pandit_bank_account_number": null,
                              "pandit_bank_ifsc_code": null
                            });
                          }
                            }
                        },
                        child: Text("Press here")));
          }),
    );
  }
}
