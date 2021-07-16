
import 'package:flutter/material.dart';
import 'dart:ui';
class PanchangTile extends StatelessWidget {
  final text;
  final date;

  const PanchangTile({Key? key, this.text, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    return Container(
      padding: EdgeInsets.all(16),
      //  height: 200,
     // height: 500,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.orange[100]),
      child: SingleChildScrollView(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: functionmain(text),
            ),
            //    Divider(thickness: 1,color: Colors.black54,),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.white),
                child: Text(
                  "${dateTime.day}-${dateTime.month}-${dateTime.year}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ))
          ],
        )),
      ),
      // color: Colors.green,
    );
  }
}

List<Widget> functionmain(String hindi) {
  List<String> text = hindi.split("<g>");
  List<String> color = [];
  List<Widget> listOfWidget = [];
  print("INITIALIZING ");
  print("${text[0]}");
  for (int i = 0; i < text.length; i++) {
    String colorCode;
    double size;
    bool bold;
    if (text[i].contains("<c")) {
      int s = text[i].indexOf("<c") + 2;
      int e = text[i].indexOf(">");
      colorCode = text[i].substring(s, e);
      text[i] = text[i].substring(e + 1, text[i].length);
    } else {
      colorCode = "#000000";
    }
    if (text[i].contains("++")) {
      text[i] = text[i].replaceAll("++", "");
      listOfWidget.add(Divider(
        thickness: 1,
        color: Colors.redAccent,
      ));
    }
    if (text[i].contains("<b")) {
      int e = text[i].indexOf(">");
      bold = true;
      text[i] = text[i].substring(e + 1, text[i].length);
    } else {
      bold = false;
    }
    if (text[i].contains("<s")) {
      int s = text[i].indexOf("<s") + 2;
      int e = text[i].indexOf(">");
      size = double.parse(text[i].substring(s, e));
      text[i] = text[i].substring(e + 1, text[i].length);
    } else {
      size = 15;
    }

    listOfWidget.add(
        textMaker(text: text[i], bold: bold, size: size, color: colorCode));
    color.add(colorCode);
  }

  return listOfWidget;
}

Widget textMaker({String? text, String? color, bool? bold, double? size}) {
  return Text(
    "$text",
    style: TextStyle(
        color: HexColor(color!),
        fontSize: size,
        fontWeight: bold! ? FontWeight.bold : FontWeight.normal),
  );
}

Widget textBox(String attribute, String value, Color aColor) {
  return Row(
    children: [
      Text(
        "$attribute",
        style: TextStyle(color: aColor, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 10,
      ),
      Text("$value")
    ],
  );
}

Widget space() {
  return Divider(
    thickness: 1,
    color: Colors.deepOrangeAccent,
  );
}

Widget headline(String value) {
  return Text(
    "$value",
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  );
}

String todayVar(String lang) {
  int week = DateTime.now().weekday;
  switch (week) {
    case 1:
      return Language(text: [
        "Somavara",
        "सोमवार",
        "সোমবার",
        "திங்கள் கிழமை",
        "సోమవారము"
      ], code: lang)
          .getText;
    case 2:
      return Language(text: [
        "Mangalavara",
        "मंगलवार",
        "মঙ্গলবার",
        "செவ்வாய் கிழமை",
        "మంగళవారము"
      ], code: lang)
          .getText;
    case 3:
      return Language(text: [
        "Buddhavara",
        "बुधवार",
        "বুধবার",
        "புதன் கிழமை",
        "బుధవారము"
      ], code: lang)
          .getText;
    case 4:
      return Language(text: [
        "Guruvara",
        "गुरूवार",
        "বৃহস্পতিবার",
        "வியாழன் கிழமை",
        "గురువారము"
      ], code: lang)
          .getText;
    case 5:
      return Language(text: [
        "Shukravara",
        "शुक्रवार",
        "শুক্রবার",
        "வெள்ளி கிழமை",
        "శుక్రవారము"
      ], code: lang)
          .getText;
    case 6:
      return Language(
              text: ["Shanivara", "शनिवार", "শনিবার", "சனி கிழமை", "శనివారము"],
              code: lang)
          .getText;
    case 7:
      return Language(text: [
        "Ravivara",
        "रविवार",
        "রবিবার",
        "ஞாயிற்று கிழமை",
        "ఆదివారము"
      ], code: lang)
          .getText;
    default:
      return "null";
  }
}

String getpaksha(String value, String lang) {
  switch (value) {
    case "K":
      print("$value");
      return Language(
              text: ["Krishna", "कृष्ण", "কৃষ্ণ", "தேய்பிறை", "కృష్ణ"],
              code: lang)
          .getText;
    case "k":
      print("$value");
      return Language(
              text: ["Krishna", "कृष्ण", "কৃষ্ণ", "தேய்பிறை", "కృష్ణ"],
              code: lang)
          .getText;
    case "S":
      return Language(
              text: ["Shukla", "शुक्ल", "শুক্ল", "வளர்பிறை", "శుక్ల"],
              code: lang)
          .getText;
    case "s":
      return Language(
              text: ["Shukla", "शुक्ल", "শুক্ল", "வளர்பிறை", "శుక్ల"],
              code: lang)
          .getText;
    default:
      return "null";
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}class Language {
  final String? language;
  final String? code;
  final List<String>? text;

  Language({this.text, this.language, this.code});

  String? get getCode {
    switch (language) {
      case "English":
        return "ENG";
        break;
      case "हिन्दी":
        return "HIN";
        break;
      case "বাঙ্গালী":
        return "BAN";
        break;
      case "தமிழ்":
        return "TAM";
        break;
      case "తెలుగు":
        return "TEL";
        break;
    }
    return null;
  }

  String get getText {
    switch (code) {
      case "ENG":
        return "${text![0]}";
        break;
      case "HIN":
        return "${text![1]}";
        break;
      case "BAN":
        return "${text![2]}";
        break;
      case "TAM":
        return "${text![3]}";
        break;
      case "TEL":
        return "${text![4]}";
        break;
    }
    return text![0];
  }

  String? get getLang {
    switch (code) {
      case "ENG":
        return "English";
        break;
      case "HIN":
        return "हिन्दी";
        break;
      case "BAN":
        return "বাঙ্গালী";
        break;
      case "TAM":
        return "தமிழ்";
        break;
      case "TEL":
        return "తెలుగు";
        break;
    }
    return null;
  }
}
