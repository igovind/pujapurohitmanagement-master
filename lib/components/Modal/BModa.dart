class BModal {
  final String? name,type,region,searchKey,uid,photoUrl,quote,coverpic,token;
  final int? experience;
  final double? swastik;
  final Map? location;
  final String? dob;
  final String? last;
  final String? pujapic;

  BModal({this.pujapic,this.last,this.dob,this.location,this.token,this.type, this.region, this.name, this.experience,this.searchKey,this.uid,this.photoUrl,this.quote,this.coverpic,this.swastik});
  factory BModal.fromMap(Map<String , dynamic>data){

    final Map? location =data['location'];
    final last=data['lastName'];
    final dob=data['dateOfBirth'];
    final String? token=data['token'];
    final String? name = data['firstName'];
    final String? type = data['type'];
    final int? experience = data['experience'];
    final String? region=data['state'];
    final String? searchKey=data['searchKey'];
    final String? uid=data['uid'];
    final String? photoUrl=data['profilePicUrl'];
    final String? quote=data['aboutYou'];
    final double? swastik=data['swastik'];
    final String? coverpic=data['coverpic'];
    return BModal(
      last: last,
      location: location,
      dob: dob,
      token: token,
      name: name,
      type: type,
      experience: experience,
      region: region,
      searchKey: searchKey,
      uid:uid,
      photoUrl: photoUrl,
      quote: quote,
      coverpic: coverpic,
      swastik:swastik,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'token':token,
        'uid':uid,
        'name':name,
        'type':type,
        'experience':experience,
        'region':region,
        'photoUrl':photoUrl,
        'Quote':quote,
        'coverpic':coverpic,
        'searchKey':name![0].toUpperCase(),
        'swastik':swastik,
      };
  }
}