import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //method to store user name and email in shared pref
  static Future<void> storeUserDetails(
    {required String userName,
    required String email,
    required String password,
    required String confermPassword,
    required BuildContext context,}
  ) async {
   
    try {
       //chek weather the user entered password and the conferm password are the same
    if (password != confermPassword) {
      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("password and confirm password do not match")),
      );
    }
    //if the user password and conf password are asme then store the user name and email.
    
      //create and instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //stre the username and email as key value pairs
      await prefs.setString("username", userName);
      await prefs.setString(email, email);
      //show amesage to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("user details stored successfully")),
      );
    } catch (err) {
      err.toString();
    }
  }

  //method to check weather the username is saved in the shared pref
  static Future<bool>checkUsername()async{
    //create a instance for shared pref
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? userName= prefs.getString("username");
    return userName !=null;
  }
}
