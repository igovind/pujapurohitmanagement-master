import 'package:flutter/material.dart';

class Role extends StatelessWidget {
  final String? ceo;
  final String? members;

  const Role({
    Key? key,
   this.ceo,this.members
  }) : super(key: key);

  static String isceo() {
    return 'ceo';
  }

  static String ismember() {
    return 'member';
  }

  /*static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }*/

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}