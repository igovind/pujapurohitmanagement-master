import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pujapurohitmanagement/components/Modal/BModa.dart';
import 'package:pujapurohitmanagement/components/Modal/Rashimodal.dart';
import 'package:pujapurohitmanagement/components/Modal/Trending.dart';
import 'package:pujapurohitmanagement/components/Modal/admin.dart';
import 'package:pujapurohitmanagement/components/Modal/booking.dart';
import 'package:pujapurohitmanagement/components/Modal/refund.dart';
import 'package:pujapurohitmanagement/components/Modal/vendor.dart';
import 'api.dart';
import 'firestore.dart';


abstract class Database{
  Stream<List<TrendingModal>> Trendings();
  Stream<List<RashifalModal>> readrashifal();
  Stream<List<BookingModal>> booking();
  Stream<List<BookingModal>> Rbooking();
  Future<void> updateData(RashifalModal rashifalModal,String sign);
  Stream<List<BModal>> Bhrahmans();
  Future<void> updateVData(VModal vModal,String uid);
  Stream<List<Refund>> Return();
  Stream<List<AdminModal>> Admin();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service =FirestoreService();

  String ChatDate() => DateFormat.MMMMEEEEd().format(DateTime.now());
  String TextTime() => DateTime.now().toIso8601String();
  FirestoreDatabase( {required this.uid}) ;

  @override
  Future<void> updateData(RashifalModal rashifalModal,String sign) async {
    final path = APIPath.updaterashi(sign);
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.update(rashifalModal.toMap());
  }

  //Vendors
  @override
  Future<void> updateVData(VModal vModal,String uid) async {
    final path = APIPath.Vendor(uid);
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(vModal.toMap());
  }





                              // All Streams Reading//
  //Read Admin
  @override
  Stream<List<AdminModal>> Admin()=>_service.collectionStream(
      path: APIPath.Admin(),
      builder: (data)=>AdminModal.fromMap(data));
  //Read Bhrahmans
  @override
  Stream<List<BModal>> Bhrahmans()=>_service.collectionStream(
      path: APIPath.bhrahman(),
      builder: (data)=>BModal.fromMap(data));
  //Read Trendings
  @override
  Stream<List<TrendingModal>> Trendings()=>_service.trendStream(
      path: APIPath.Trending(),
      builder: (data)=>TrendingModal.fromMap(data));

  //Read Rashifal
  @override
  Stream<List<RashifalModal>> readrashifal()=>_service.rashifalStream(
      path: APIPath.rashi(),
      builder: (data)=>RashifalModal.fromMap(data));
  //Reading bookings
  @override
  Stream<List<BookingModal>> booking()=>_service.timeStream(
      path: APIPath.booking(),
      builder: (data)=>BookingModal.fromMap(data));
  //Reading Rbookings
  @override
  Stream<List<BookingModal>> Rbooking()=>_service.timeStream(
      path: APIPath.Rbooking(),
      builder: (data)=>BookingModal.fromMap(data));
  //Reading Refunds,
  Stream<List<Refund>> Return()=>_service.SimpleStream(
      path: APIPath.Loss(),
      builder: (data)=>Refund.fromMap(data));
}