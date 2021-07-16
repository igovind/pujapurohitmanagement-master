import 'package:cloud_firestore/cloud_firestore.dart';
class Refund {
  final Timestamp? Booking_time;
  final Timestamp? Booking_for;
  final Timestamp? Claim_time;
  final Timestamp? cancel_time;
  final String?  Booked_by;
  final String? Booked_purohit;
  final double? total;
  final double? Transaction;
  final String? vendor;
  final String? contact;
  final bool? cod;
  final bool? refunded;
  final String? clientuid;
  final dynamic bookingId;
  Refund({this.clientuid,this.bookingId,this.refunded,this.Booking_time, this.Booking_for, this.Claim_time, this.cancel_time, this.Booked_by, this.Booked_purohit, this.total, this.Transaction, this.vendor, this.contact, this.cod,});
  factory Refund.fromMap(Map<String , dynamic>data){

    final String? clientuid=data['clientuid'];
    final int? bookingId=data['bookingId'];
    final Timestamp? Booking_time=data['Boking_time'];
    final Timestamp? Booking_for=data['Booking_for'];
    final Timestamp? Claim_time=data['Claim_time'];
    final Timestamp? cancel_time=data['cancel_time'];
    final String?  Booked_by=data['Booked_by'];
    final String? Booked_purohit=data['Booked_purohit'];
    final double? total=data['total'];
    final double? Transaction=data['Transcatiom'];
    final String? vendor=data['vendor'];
    final String? contact=data['contact'];
    final bool? cod=data['Cod'];
    final bool? refunded=data['Refunded'];

    return Refund(
      clientuid: clientuid,
      bookingId: bookingId,
        refunded: refunded,
    Booked_by: Booked_by,
    Booked_purohit: Booked_purohit,
    Booking_for: Booking_for,
    Booking_time: Booking_time,

    total: total,
    Transaction: Transaction,
    vendor: vendor,
    contact: contact,
    cancel_time: cancel_time,
    cod: cod,
    Claim_time: Claim_time
    );
  }
}