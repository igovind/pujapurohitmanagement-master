class APIPath{
  //Reading RBookings
  static String Rbooking()=>'RBOOKING';
  //Reading Bookings
  static String booking()=>'Bookings';
 //Reading Rashifal()=>
  static String rashi()=>'rashifal';
  //Reading updateRashifal()=>
  static String updaterashi(String sign)=>'/rashifal/${sign}';
  // Trending
  static String Trending()=>'Trending';
  static String bhrahman()=>'Avaliable_pundit';
  //Vendors
  static String Vendor(String uid)=>'Vendors/$uid';
  //Refund
  static String Loss()=>'Refund';

  //admin
  static String Admin()=>'Admin';

}