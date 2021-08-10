import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohitmanagement/pages/manage/notice_board/notice_form.dart';

class NoticeBoard extends StatelessWidget {
  final List<dynamic> noticeList;

  const NoticeBoard({Key? key, required this.noticeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("Add"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .doc("inventories/state")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return NoticeForm(
                      value: null,
                    );
                  })));
        },
      ),
      appBar: AppBar(),
      body: noticeList.isEmpty
          ? Center(
              child: Text("Empty"),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    DateTime dateTime = noticeList[index]["date"].toDate();
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 3)
                          ]),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .doc("inventories/state")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return NoticeForm(
                                      value: noticeList[index],
                                    );
                                  })));
                        },
                        leading: Text("${index + 1}  "),
                        trailing: noticeList[index]["important"]
                            ? Icon(
                                Icons.circle,
                                color: Colors.red,
                              )
                            : SizedBox(),
                        title: Text("${noticeList[index]["title"][0]}"),
                        subtitle: Column(
                          children: [
                            Text("${noticeList[index]["subtitle"][0]}"),
                            Text(
                              "${dateTime.year}/${dateTime.month}/${dateTime.day}--${dateTime.hour}:${dateTime.minute}",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.black,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .doc(
                                                            "inventories/tab_bar_icons")
                                                        .update({
                                                      "notice_board": FieldValue
                                                          .arrayRemove([
                                                        noticeList[index]
                                                      ])
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("YES")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("NO"))
                                            ],
                                            content: Text(
                                                "Are you sure that you want to delete this puja?"),
                                            title: Text("DELETE THIS PUJA"),
                                          ));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: noticeList.length),
            ),
    );
  }
}
