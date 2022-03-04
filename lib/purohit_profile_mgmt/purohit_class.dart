import 'package:cloud_firestore/cloud_firestore.dart';

class Purohit {
  final DocumentSnapshot snapshot;

  Purohit(this.snapshot);

  dynamic get name => snapshot.data()!["pandit_name"];

  dynamic get bio => snapshot.data()!["pandit_bio"];

  dynamic get age => snapshot.data()!["pandit_age"];

  dynamic get mobile => snapshot.data()!["pandit_mobile_number"];

  dynamic get city => snapshot.data()!["pandit_city"];

  dynamic get state => snapshot.data()!["pandit_state"];

  dynamic get expertise => snapshot.data()!["pandit_expertise"];

  dynamic get experience => snapshot.data()!["pandit_experience"];

  dynamic get qualification => snapshot.data()!["pandit_qualification"];

  bool get verification => snapshot.data()!["pandit_verification_status"];

  dynamic get swastik => snapshot.data()!["pandit_swastik"];

  dynamic get profileUrl => snapshot.data()!["pandit_display_profile"] == null
      ? "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png"
      : snapshot.data()!["pandit_display_profile"];

  dynamic get coverUrl => snapshot.data()!["pandit_cover_profile"];

  dynamic get pictures => snapshot.data()!["pandit_pictures"] == null
      ? [null, null, null, null]
      : snapshot.data()!["pandit_pictures"];

  dynamic get type => snapshot.data()!["pandit_type"];

  dynamic get joining => snapshot.data()!["pandit_joining_date"];

  dynamic get update => snapshot.data()!["pandit_profile_update_date"];

  dynamic get language => snapshot.data()!["pandit_language"];

  dynamic get appLanguage => snapshot.data()!["pandit_app_language_code"];

  dynamic get email => snapshot.data()!["pandit_email"];

  dynamic get id => snapshot.data()!["pandit_id"];

  dynamic get uid => snapshot.id;
}
