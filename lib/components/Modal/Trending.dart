class TrendingModal {
  final String? name,least,image,keyword;
  final int? num;
  TrendingModal({this.name,this.keyword, this.num,this.least,this.image });
  factory TrendingModal.fromMap(Map<String , dynamic>data){
    final String? keyword=data['keyword'];
    final String? name=data['name'];
    final String? least=data['least'];
    final String? image=data['image'];
    final int? num=data['num'];
    return TrendingModal(
      keyword: keyword,
      name: name,
      num: num,
      least: least,
      image: image,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'keyword':keyword,
        'image':image,
        'least':least,
        'name':name,
        'num':num,
      };
  }
}