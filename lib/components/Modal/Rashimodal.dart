class RashifalModal {
  final String? Edetail;
  final String? Ename;
  final String? Hdetail;
  final String? Hname;
  RashifalModal({this.Edetail, this.Ename, this.Hdetail, this.Hname,});
  factory RashifalModal.fromMap(Map<String , dynamic>data){

    final String? Edetail=data['Edetail'];
    final String? Ename=data['Ename'];
    final String? Hdetail=data['Hdetail'];
    final String? Hname=data['Hname'];
    return RashifalModal(
      Edetail:Edetail,
      Ename:Ename,
      Hdetail:Hdetail,
      Hname:Hname,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'Edetail':Edetail,
        'Ename':Ename,
        'Hdetail':Hdetail,
        'Hname':Hname
      };
  }
}