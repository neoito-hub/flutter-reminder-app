// import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Login
   login() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simulate a future for response after 2 second.
    //  await new Future<bool>.delayed(
    //   new Duration(
    //     seconds: 2
    //   ), () {
        if(prefs.getString('user_id')!=null){
          return true;
      }else{
        return false;
      }
      }
    // );
  // }
}