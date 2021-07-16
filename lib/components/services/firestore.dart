import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';


class FirestoreService{
  Future<void> setData({required String path, required Map<String, dynamic>data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

//_____________________________Favourite___________________________________//
  Stream<List<T>> SimpleStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((snapshot) => builder(snapshot.data())).toList());
  }

  // ____________________________Trendings____________________________//
  Stream<List<T>> trendStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path).orderBy('num').limit(10);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.reversed.map((snapshot) => builder(snapshot.data())).toList());
  }
// ____________________________Rahifal____________________________//
  Stream<List<T>> rashifalStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path).orderBy('num');
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((snapshot) => builder(snapshot.data())).toList());
  }
// ____________________________Common____________________________//
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path).orderBy("swastik");
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.reversed.map((snapshot) => builder(snapshot.data())).toList());
  }
  Stream<List<T>> timeStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path).orderBy('timestrap');
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.reversed.map((snapshot) => builder(snapshot.data())).toList());
  }

}