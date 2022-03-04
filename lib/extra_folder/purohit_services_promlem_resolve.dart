import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurohitServiceProblemResolve extends StatefulWidget {
  const PurohitServiceProblemResolve({Key? key}) : super(key: key);

  @override
  _PurohitServiceProblemResolveState createState() =>
      _PurohitServiceProblemResolveState();
}

class _PurohitServiceProblemResolveState
    extends State<PurohitServiceProblemResolve> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> map = {
      "satnarayan": "PJID2021824205131",
      "#teej": "PJID2021822181951",
      "#karwachauth": "PJID202182218013",
      "#Vahan": "PJID202182122945",
      "#bhumi": "PJID2021822173446",
      "#durga": "PJID202182217469",
      "#ganesh": "PJID2021822174849",
      "#ghar": "PJID202182217519",
      "#holi": "PJID2021822175320",
      "#janew": "PJID2021822175528",
      "#kali": "PJID2021822175826",
      "#mritunjaya": "PJID202182218734",
      "#laxmipuja": "PJID202182218520",
      "#saraswatipuja": "PJID2021822181540",
      "#janmastmi": "PJID202182218248",
      "#shiv": "PJID20211111153134",
    };
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .doc('inventories/listed_puja')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: TextButton(
                child: Text("Press me"),
                onPressed: () async {
                List<dynamic> s=snapshot.data!["listed_puja"];
                for(int i=0;i<s.length;i++){
                  if(s[i]["pjid"]=="PJID2021822181951"){
                    FirebaseFirestore.instance.doc('assets_folder/puja_ceremony_folder/folder/PJID2021822181951').set(
                        {
                          "puja_ceremony_name": snapshot.data!.get("listed_puja")[i]
                          ["name"],
                          "puja_ceremony_performing_pandits": 0,
                          "puja_ceremony_promise": null,
                          "puja_ceremony_standard_price": null,
                          "puja_ceremony_steps": null,
                          "puja_ceremony_key_insights": null,
                          "puja_ceremony_display_picture":
                          snapshot.data!.get("listed_puja")[i]["image"],
                          "puja_ceremony_standard_duration":
                          snapshot.data!.get("listed_puja")[i]["avgDuration"],
                          "puja_ceremony_description":
                          snapshot.data!.get("listed_puja")[i]["description"],
                          "puja_ceremony_date_of_creation":
                          snapshot.data!.get("listed_puja")[i]["doc"],
                          "puja_ceremony_type_filter": null,
                          "puja_ceremony_god_filter": null,
                          "puja_ceremony_benefits_filter": null,
                          "puja_ceremony_id": snapshot.data!.get("listed_puja")[i]
                          ["pjid"],
                        });
                  }
                }
                },
              ),
            );
          }),
    );
  }
}
//map[event.docs[j].get("puja_ceremony_keyword")]
