class Order_basic {
  final String? address,contact,name,otp,location,deliver_before,date,time;
  final bool? delivered;
  final double? total;
  final int? orderId;
  final bool? cod;
  final dynamic delivery_time;
  Order_basic( {this.address,this.date, this.time,this.cod,this.delivery_time,this.orderId,this.deliver_before,this.location,this.name,this.contact, this.otp, this.delivered, this.total,});
  factory Order_basic.fromMap(Map<String , dynamic>data){

    final String? address=data['address'];
    final String? date=data['date'];
    final String? time=data['time'];
    final bool? cod=data['cod'];
    final dynamic delivery_time=data['delivery_time'];
    final bool? delivered=data['delivered'];
    final int? orderId=data['orderId'];
    final String? deliver_before=data['deliver_before'];
    final String? location=data['locatin'];
    final String? otp=data['otp'];
    final String? name=data['name'];
    final String? contact=data['contact'];
    final double? total=data['total'] ;
    return Order_basic(
      address: address,
      date: date,
      time: time,
      cod: cod,
      delivery_time: delivery_time,
      delivered: delivered,
      orderId: orderId,
      deliver_before: deliver_before,
      location: location,
      name: name,
      otp: otp,
      contact: contact,
      total: total,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'address':address,
        'time':time,
        'date':date,
        'cod':cod,
        'delivery_time':delivery_time,
        'delivered': delivered,
        'orderId': orderId,
        'deliver_before': deliver_before,
        'location': location,
        'name': name,
        'otp': otp,
        'contact': contact,
        'total': total,
      };
  }
}