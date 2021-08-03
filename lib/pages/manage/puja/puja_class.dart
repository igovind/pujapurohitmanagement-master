import '../panchang_tile.dart';

class Puja {
  final List<dynamic> value;
  final languageCode;
  final state;
  final List<dynamic>? samagriList;
  final int index;

  Puja(
      {this.state,
      this.samagriList,
      required this.index,
      required this.value,
      this.languageCode});

  String get name =>
      Language(code: "$languageCode", text: value[index]["name"]).getText;

  String get description =>
      Language(code: "$languageCode", text: value[index]["description"])
          .getText;

  String get image => value[index]["image"];

  String get id => value[index]["pjid"];

  String get duration => value[index]["avgDuration"];

  String get keyword => value[index]["keyword"];

  String get type => value[index]["type"];

  List<dynamic> get samagri => value[index]["samagri"]["$state"] == null
      ? []
      : value[index]["samagri"]["$state"];
}

class Samagri {
  final List<dynamic>? listOfSamagri;
  final languageCode;

  Samagri({this.languageCode, this.listOfSamagri});

  Map<String, String> get names {
    Map<String, String> list = {};
    listOfSamagri!.forEach((element) {
      list.addAll({
        "${element["sid"]}":
            "${Language(text: element["name"], code: languageCode).getText}"
      });
    });
    return list;
  }

  Map<String, String> get description {
    Map<String, String> list = {};
    listOfSamagri!.forEach((element) {
      list.addAll({
        "${element["sid"]}":
            "${Language(text: element["description"], code: languageCode).getText}"
      });
    });
    return list;
  }

  Map<String, String> get image {
    Map<String, String> list = {};
    listOfSamagri!.forEach((element) {
      list.addAll({"${element["sid"]}": "${element["image"]}"});
    });
    return list;
  }

  Map<dynamic, int> get indexValue {
    Map<dynamic, int> list = {};
    for (int i = 0; i < listOfSamagri!.length; i++) {
      list.addAll({"${listOfSamagri![i]["sid"]}": i});
    }
    return list;
  }
}

class SamagriDetails {
  final List<dynamic> mainListOfSamagri;
  final String samagriId;

  SamagriDetails({required this.mainListOfSamagri, required this.samagriId});

  Map<dynamic, dynamic> get details {
    List<dynamic> samagriList = [];
    mainListOfSamagri.forEach((element) {
      samagriList.add(element["sid"]);
    });
    if (samagriList.contains(samagriId)) {
      int index = samagriList.indexOf(samagriId);
      return mainListOfSamagri[index];

    }
    return {};
  }

}
class SamagriD{
  final name;
  final description;
  final image;
  final price;
  final sid;

  SamagriD({this.name, this.description, this.image, this.price, this.sid});

}