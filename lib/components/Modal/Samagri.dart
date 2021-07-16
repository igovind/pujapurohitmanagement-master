class SamagriModal {
  final String? name,more,doc;
  final double? price;

  SamagriModal( {this.more, this.doc,this.name,this.price});
  factory SamagriModal.fromMap(Map<String , dynamic>data){

    final String? name=data['name'];
    final String? doc=data['doc'] ;
    final String? more=data['more'];
    final double? price=data['price'];

    return SamagriModal(
      name: name,
      price: price,
      more:more,
      doc: doc,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'doc':doc,
        'more':more,
        'name':name,
        'price':price,
      };
  }
}