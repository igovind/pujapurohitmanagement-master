import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/reusable_widgets.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/magic_screen.dart';

import 'purohit_class.dart';

class PurohitBasicDetailsForm extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const PurohitBasicDetailsForm({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<PurohitBasicDetailsForm> createState() => _PurohitBasicDetailsFormState();
}

class _PurohitBasicDetailsFormState extends State<PurohitBasicDetailsForm> {
  bool updating = false;
  List<DropdownMenuItem> languageItems = [
    DropdownMenuItem(
      value: 'Hindi',
      child: Text('Hindi'),
    ),
    DropdownMenuItem(
      value: 'English',
      child: Text('English'),
    ),
    DropdownMenuItem(
      value: 'Kannada',
      child: Text('Kannada'),
    ),
    DropdownMenuItem(
      value: 'Malayalam',
      child: Text('Malayalam'),
    ),
    DropdownMenuItem(
      value: 'Odia',
      child: Text('Odia'),
    ),
    DropdownMenuItem(
      value: 'Punjabi',
      child: Text('Punjabi'),
    ),
    DropdownMenuItem(
      value: 'Gujarati',
      child: Text('Gujarati'),
    ),
    DropdownMenuItem(
      value: 'Urdu',
      child: Text('Urdu'),
    ),
    DropdownMenuItem(
      value: 'Tamil',
      child: Text('Tamil'),
    ),
    DropdownMenuItem(
      value: 'Telugu',
      child: Text('Telugu'),
    ),
    DropdownMenuItem(
      value: 'Marathi',
      child: Text('Marathi'),
    ),
    DropdownMenuItem(
      value: 'Bengali',
      child: Text('Bengali'),
    ),
  ];

  bool _verified = false;
  String? name;
  String? bio;
  String? mobile;
  int? age;
  String? state;
  String? city;
  String? experience;
  String? expertise;
  String? qualification;
  String? type;
  int? swastik;
  List<dynamic>? pictures;
  String? language;
  String? profile;
  String? cover;

  @override
  void initState() {
    _verified = Purohit(widget.documentSnapshot).verification;
    name = Purohit(widget.documentSnapshot).name;
    bio = Purohit(widget.documentSnapshot).bio;
    mobile = Purohit(widget.documentSnapshot).mobile;
    age = Purohit(widget.documentSnapshot).age;
    state = Purohit(widget.documentSnapshot).state;
    city = Purohit(widget.documentSnapshot).city;
    experience = "${Purohit(widget.documentSnapshot).experience}";
    expertise = Purohit(widget.documentSnapshot).expertise;
    qualification = Purohit(widget.documentSnapshot).qualification;
    type = Purohit(widget.documentSnapshot).type;
    swastik = Purohit(widget.documentSnapshot).swastik;
    pictures = Purohit(widget.documentSnapshot).pictures;
    language = Purohit(widget.documentSnapshot).language;
    cover = Purohit(widget.documentSnapshot).coverUrl;
    profile = Purohit(widget.documentSnapshot).profileUrl;

    //for(int i=0;i<)
    super.initState();
  }

//String name=Purohit(widget.documentSnapshot).name;
  @override
  Widget build(BuildContext context) {
    List<String> states = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttarakhand",
      "Uttar Pradesh",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli and Daman & Diu",
      "Delhi",
      "Jammu & Kashmir",
      "Ladakh",
      "Lakshadweep",
      "Puducherry",
    ];
    List<DropdownMenuItem<String>> experienceItems =
        List<DropdownMenuItem<String>>.generate(
            100,
            (index) => DropdownMenuItem(
                  child: Text("$index Years"),
                  value: "$index",
                ));
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < states.length; i++) {
      items.add(DropdownMenuItem<String>(
        child: Text(states[i]),
        value: states[i],
      ));
    }
    final _nPFormKey = GlobalKey<FormState>();
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("Save"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Profile update"),
                  content: Text("Are you sure that you want to update?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            updating = true;
                          });
                          _nPFormKey.currentState!.save();
                          Navigator.of(context).pop();
                          FirebaseFirestore.instance
                              .doc(
                                  'users_folder/folder/pandit_users/${Purohit(widget.documentSnapshot).uid}')
                              .update({
                            "pandit_name": name,
                            "pandit_bio": bio,
                            "pandit_state": state,
                            "pandit_city": city,
                            "pandit_age": age,
                            "pandit_qualification": qualification,
                            "pandit_verification_status": _verified,
                            "pandit_mobile_number": mobile,
                            "pandit_swastik": swastik,
                            "pandit_type": type,
                            "pandit_display_profile": profile,
                            "pandit_cover_profile": cover,
                            "pandit_profile_update_date":
                                FieldValue.arrayUnion([DateTime.now()]),
                            "pandit_language": language,
                            "pandit_expertise": expertise,
                            "pandit_experience": experience,
                            "pandit_pictures": pictures,
                          }).whenComplete(() {
                            setState(() {
                              updating = false;
                            });
                          });
                        },
                        child: Text("Update")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"))
                  ],
                );
              });
        },
      ),
      body: updating
          ? Center(
              child: Text("Please wait"),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _nPFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Profile Pic",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        CustomImageUploader(
                            imageWidth:
                                MagicScreen(context: context, width: 300)
                                    .getWidth,
                            imageHeight:
                                MagicScreen(context: context, height: 300)
                                    .height,
                            networkImageUrl: profile,
                            path:
                                'Users/${Purohit(widget.documentSnapshot).uid}/profilePicFile',
                            onPressed: (String string) {
                              profile = string;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Cover Pic",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        CustomImageUploader(
                            imageWidth:
                                MagicScreen(context: context, width: 650)
                                    .getWidth,
                            imageHeight:
                                MagicScreen(context: context, height: 350)
                                    .getHeight,
                            networkImageUrl: cover,
                            path:
                                'Users/${Purohit(widget.documentSnapshot).uid}/coverPicFile',
                            onPressed: (String string) {
                              cover = string;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "PANDIT ID: ${Purohit(widget.documentSnapshot).id}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "PANDIT UID: ${Purohit(widget.documentSnapshot).uid}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "PANDIT EMAIL: ${Purohit(widget.documentSnapshot).email}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "PANDIT JOINING DATE: ${DateTime.fromMicrosecondsSinceEpoch((Purohit(widget.documentSnapshot).joining).microsecondsSinceEpoch)}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 200,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: Column(
                              children: [
                                Text(
                                  "Pandit Verification",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: _verified,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _verified = value;
                                    });
                                    print(">>>>> $value");
                                  },
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                lable: "Name of Purohit",
                                initialText: name,
                                onPress: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                              ),
                              CustomTextFormField(
                                lable: "Age of Purohit",
                                initialText: "$age",
                                onPress: (value) {
                                  setState(() {
                                    age = int.parse(value);
                                  });
                                },
                              ),
                              CustomTextFormField(
                                lable: "Bio of Purohit",
                                initialText: bio,
                                onPress: (value) {
                                  setState(() {
                                    bio = value;
                                  });
                                },
                              ),
                              CustomTextFormField(
                                lable: "Mobile Number of Purohit",
                                initialText: mobile,
                                onPress: (value) {
                                  mobile = value;
                                },
                              ),
                              CustomDropdownMenu(
                                items: items,
                                lable: "State of Purohit",
                                onChanged: (value) {
                                  state = value;
                                },
                                value: state,
                              ),
                              CustomDropdownMenu(
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Acharya"),
                                    value: "Acharya",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Shastri"),
                                    value: "Shastri",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Brahmin"),
                                    value: "Brahmin",
                                  ),
                                ],
                                lable: "Type of Purohit",
                                onChanged: (value) {
                                  type = value;
                                },
                                value: type,
                              ),
                              CustomTextFormField(
                                lable: "City of Purohit",
                                initialText: city,
                                onPress: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                              ),
                              CustomDropdownMenu(
                                items: experienceItems,
                                lable: "Experience of Purohit",
                                onChanged: (value) {
                                  experience = value;
                                },
                                value: experience,
                              ),
                              CustomTextFormField(
                                lable: "Qualification of Purohit",
                                initialText: qualification,
                                onPress: (value) {
                                  qualification = value;
                                },
                              ),
                              CustomTextFormField(
                                lable: "Expertise of Purohit",
                                initialText: expertise,
                                onPress: (value) {
                                  setState(() {
                                    expertise = value;
                                  });
                                },
                              ),
                              CustomTextFormField(
                                lable: "Swastik of Purohit",
                                initialText: "$swastik",
                                onPress: (value) {
                                  setState(() {
                                    swastik = int.parse(value);
                                  });
                                },
                              ),
                              CustomTextFormField(
                                lable: "Languages of Purohit",
                                initialText: language,
                                onPress: (value) {
                                  setState(() {
                                    language = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Column(
                            children: [
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomImageUploader(
                                  networkImageUrl: pictures![0],
                                  imageHeight:
                                      MagicScreen(context: context, height: 350)
                                          .getHeight,
                                  imageWidth:
                                      MagicScreen(context: context, width: 650)
                                          .getWidth,
                                  path:
                                      'Users/${Purohit(widget.documentSnapshot).uid}/1',
                                  onPressed: (String string) {
                                    pictures![0] = string;
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              CustomImageUploader(
                                  networkImageUrl: pictures![1],
                                  imageHeight:
                                      MagicScreen(context: context, height: 350)
                                          .getHeight,
                                  imageWidth:
                                      MagicScreen(context: context, width: 650)
                                          .getWidth,
                                  path:
                                      'Users/${Purohit(widget.documentSnapshot).uid}/2',
                                  onPressed: (String string) {
                                    pictures![1] = string;
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              CustomImageUploader(
                                  networkImageUrl: pictures![2],
                                  imageHeight:
                                      MagicScreen(context: context, height: 350)
                                          .getHeight,
                                  imageWidth:
                                      MagicScreen(context: context, width: 650)
                                          .getWidth,
                                  path:
                                      'Users/${Purohit(widget.documentSnapshot).uid}/3',
                                  onPressed: (String string) {
                                    pictures![2] = string;
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              CustomImageUploader(
                                  networkImageUrl: pictures![3],
                                  imageHeight:
                                      MagicScreen(context: context, height: 350)
                                          .getHeight,
                                  imageWidth:
                                      MagicScreen(context: context, width: 650)
                                          .getWidth,
                                  path:
                                      'Users/${Purohit(widget.documentSnapshot).uid}/4',
                                  onPressed: (String string) {
                                    pictures![3] = string;
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
