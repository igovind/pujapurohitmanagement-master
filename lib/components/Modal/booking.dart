class BookingModal {
  final String? panditpic,phone,serviceId,link,otp,paymentId,btoken,utoken,ServiceType,Date,pic,time,address,cleint,purohit,location,clientuid,pandituid;
  final double? ServiceCharge;
  final double? Total;
  final double? AmountPaid;
  final double? Due;
  final double? convineancefee;
  final int? bookingId;
  final bool? request;
  final bool? rejected;
  final bool? payment;
  final bool? puja_status;
  final bool? rating;
  final bool? samagri;
  final double? swastik;
  final bool? cod;
  final double? samagri_price;
  final bool? cancel;
  final double? transaction;
  final double? puja_charge;
  final double? price;
  final dynamic timestrap;
  final String? service;

  BookingModal({this.service,this.panditpic,this.timestrap,this.price,this.puja_charge,this.transaction,this.phone,this.cancel,this.samagri_price,this.cod,this.serviceId,this.link,this.samagri,this.otp,this.paymentId,this.swastik,this.rating,this.puja_status,this.btoken,this.utoken,this.pic,this.time,this.clientuid, this.pandituid,this.payment,this.location,
    this.convineancefee,this.rejected, this.bookingId,this.request,
    this.address,this.cleint,this.AmountPaid,this.Date,this.Due,this.purohit,
    this.ServiceCharge,this.ServiceType,this.Total});
  factory BookingModal.fromMap(Map<String , dynamic>data){

    final String? service=data['service'];
    final String? panditpic=data['panditpic'];
    final dynamic timestrap=data['timestrap'];
    final double? price=data['price'];
    final double? transaction=data['transaction'];
    final double? puja_charge=data['puja_charge'];
    final String? phone=data['contact'];
    final bool? cancel=data['cancel'];
    final double? samagri_price=data['samagri_price'];
    final bool? cod=data['cod'];
    final String? serviceId=data['serviceId'];
    final String? link=data['Link'];
    final bool? samagri=data['samagri'];
    final String? otp=data['otp'];
    final String? paymentId=data['paymentId'];
    final double? swastik=data['swastik'];
    final String? btoken=data['btoken'];
    final String? utoken=data['utoken'];
    final String? pic=data['pic'];
    final String? address=data['Location'];
    final String? time=data['time'];
    final String? ServiceType=data['service'];
    final String? clientuid=data['clientuid'];
    final String? pandituid=data['pandituid'];
    final String? location=data['Link'];
    final double? ServiceCharge=data['price'];
    final double? convineancefee=data['convineancefee'];
    final double? AmountPaid=data['AmountPaid'];
    final String? Date=data['date'];
    final double? Due=data['Due'];
    final String? purohit=data['pandit'];
    final double? Total=data['total'];
    final String? client=data['client'];
    final int? bookingId=data['bookingId'];
    final bool? request=data['request'];
    final bool? rejected=data['rejected'];
    final bool? payment=data['payment'];
    final bool? puja_status=data['puja_status'];
    final bool? rating=data['rating'];
    return BookingModal(
      service: service,
        panditpic: panditpic,
        timestrap: timestrap,
        price: price,
        transaction: transaction,
        puja_charge: puja_charge,
        phone: phone,
        cancel: cancel,
        samagri_price: samagri_price,
        cod: cod,
        serviceId: serviceId,
        link: link,
        samagri: samagri,
        otp: otp,
        paymentId: paymentId,
        swastik: swastik,
        btoken: btoken,
        utoken: utoken,
        pic: pic,
        time: time,
        address: address,
        ServiceType:ServiceType,
        clientuid: clientuid,
        pandituid: pandituid,
        ServiceCharge: ServiceCharge,
        convineancefee: convineancefee,
        AmountPaid: AmountPaid,
        Date: Date,
        Due: Due,
        purohit: purohit,
        Total: Total,
        cleint: client,
        request: request,
        bookingId: bookingId,
        rejected: rejected,
        location: location,
        payment: payment,
        puja_status: puja_status,
        rating: rating
    );
  }

}