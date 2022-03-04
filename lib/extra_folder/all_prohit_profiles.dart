import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/purohit_class.dart';
import 'package:pujapurohitmanagement/pages/manage/custom_searchable_dropdown.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/purohit_profile_landing_page.dart';
import 'package:pujapurohitmanagement/purohit_profile_mgmt/purohit_services_page.dart';

class AllProhit extends StatelessWidget {
  const AllProhit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users_folder/folder/pandit_users")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<DropdownMenuItem> list = List<DropdownMenuItem>.generate(
              snapshot.data!.size,
              (index) => DropdownMenuItem(
                  value: Purohit(snapshot.data!.docs[index]).name +
                      Purohit(snapshot.data!.docs[index]).uid +
                      Purohit(snapshot.data!.docs[index]).mobile,
                  child: PurohitTile(
                    documentSnapshot: snapshot.data!.docs[index],
                  )));

          return Scaffold(
            appBar: AppBar(
              title: Text("All purohit profiles"),
              actions: [
                SearchChoices.single(
                  items: list,
                  value: "",
                  onChanged: () {},
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  displayClearIcon: false,
                ),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) =>
                      PurohitTile(documentSnapshot: snapshot.data!.docs[index]),
                  itemCount: snapshot.data!.size,
                )),
          );
        });
  }
}

class PurohitTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const PurohitTile({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PurohitProfileLandingPage(
                  documentSnapshot: documentSnapshot,
                )));
      },
      contentPadding: EdgeInsets.all(10),
      leading: Image.network(Purohit(documentSnapshot).profileUrl),
      title: Row(
        children: [
          Text("${Purohit(documentSnapshot).name} "),
          Purohit(documentSnapshot).verification
              ? Icon(
                  Icons.verified,
                  color: Colors.blue,
                )
              : SizedBox()
        ],
      ),
      subtitle: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black54, width: 2, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("UID: ${Purohit(documentSnapshot).uid}"),
            Text("BIO: ${Purohit(documentSnapshot).bio}"),
            Text("AGE: ${Purohit(documentSnapshot).age}"),
            Text("NUMBER: ${Purohit(documentSnapshot).mobile}"),
            Text("EXPERTISE: ${Purohit(documentSnapshot).expertise}"),
            Text("EXPERIENCE: ${Purohit(documentSnapshot).experience}"),
            Text("LANGUAGE: ${Purohit(documentSnapshot).language}"),
            Text("STATE: ${Purohit(documentSnapshot).state}"),
            Text("CITY: ${Purohit(documentSnapshot).city}"),
            Text("QUALIFICATION: ${Purohit(documentSnapshot).qualification}"),
            Text("SWASTIK: ${Purohit(documentSnapshot).swastik}"),
            Text("TYPE: ${Purohit(documentSnapshot).type}"),
            Text("EMAIL: ${Purohit(documentSnapshot).email}"),
            Text(
                "JOINING DATE: ${DateTime.fromMicrosecondsSinceEpoch((Purohit(documentSnapshot).joining).microsecondsSinceEpoch)}"),
          ],
        ),
      ),
    );
  }
}
