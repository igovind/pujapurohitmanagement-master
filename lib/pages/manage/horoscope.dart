import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohitmanagement/components/Modal/Rashimodal.dart';
import 'package:pujapurohitmanagement/components/services/database.dart';

class D4 extends StatefulWidget {
  final Database? database;


  D4({Key? key, this.database}) : super(key: key);

  @override
  _D4State createState() => _D4State();
}

class _D4State extends State<D4> {
  bool hindi=false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     // backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.translate,color: Color(0xFF8591B0),),
        onPressed: (){
          if(hindi==false){
            setState(() {
              hindi=true;
            });
          }
          else{
            setState(() {
              hindi=false;
            });
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Update',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFD3664))),

                  SizedBox(width: 10.0),
                  Text('Rashifal',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8591B0))),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top:20.0),
                  child: StreamBuilder<List<RashifalModal>>(
                      stream: widget.database!.readrashifal(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState==ConnectionState.active){
                          if(snapshot.hasData){
                            final pd=snapshot.data!;
                            // ignore: non_constant_identifier_names
                            final pdata=pd.map((RashifalModal) => rashi(rashifal: RashifalModal,hindi:hindi)).toList();
                            return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children:pdata
                            );
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                        else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class rashi extends StatelessWidget{
  final bool? hindi;
  final String? content;
  final RashifalModal? rashifal;

  rashi({Key? key,this.hindi, this.rashifal, this.content}) : super(key: key);

  TextEditingController? txt;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:148.0,right: 148.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left:10,right: 10),
            height: 180.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.black87
                )],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: _txt(content,'${hindi!?rashifal!.Hname:rashifal!.Ename}'),),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  TextField _txt(String? change,String sign){
    final maxLines = 15;
    return TextField(
      controller: txt,
      maxLines: maxLines,
      style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Montserrat',
          fontSize: 14.0),
      onChanged: (value){
        hindi!?FirebaseFirestore.instance.doc('rashifal/${rashifal!.Ename}').update({
          'Hdetail':value
        }):FirebaseFirestore.instance.doc('rashifal/${rashifal!.Ename}').update({
          'Edetail':value
        });
      },

      decoration: InputDecoration(
        labelText: sign,
        labelStyle: TextStyle(
            color: Color(0xFF8591B0),
            fontFamily: 'Montserrat',
            fontSize: 12.0),
        border: InputBorder.none,
        hintText: '${hindi!?rashifal!.Hdetail:rashifal!.Edetail}',
        hintStyle: TextStyle(
            color: Color(0xFF8591B0),
            fontFamily: 'Montserrat',
            fontSize: 12.0),
        contentPadding: EdgeInsets.only(top: 15.0,left: 10),
      ),
    );
  }
}