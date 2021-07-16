class VModal {
  final String? name,uid,token;
  final int? orders;
  final Map? location;

  VModal({this.orders,this.name,this.location,this.token,this.uid,});
  factory VModal.fromMap(Map<String , dynamic>data){
    final int? orders=data['orders'];
    final Map? location =data['location'];
    final String? token=data['token'];
    final String? name = data['firstName'];
    final String? uid=data['uid'];
    return VModal(
      orders: orders,
      location: location,
      token: token,
      name: name,
      uid:uid,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'orders':orders,
        'token':token,
        'uid':uid,
        'name':name,
        'location':location,
      };
  }
}