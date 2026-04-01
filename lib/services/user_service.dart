import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //method to store user name and email in shared pref
  static Future<void> storeUserDetails({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //chek weather the user entered password and the conferm password are the same
      if (password != confirmPassword) {
        //show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("password and confirm password do not match")),
        );
      }
      //if the user password and conf password are asme then store the user name and email.

      //create and instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //stre the username and email as key value pairs
      await prefs.setString("username", username);
      await prefs.setString("email", email);
      //show amesage to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("user details stored successfully")),
      );
    } catch (err) {
      print(err.toString());
    }
  }

  //method to check weather the username is saved in the shared pref
  static Future<bool> checkUsername() async {
    //create a instance for shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    return username != null;
  }

  //get the usename and the email
  static Future<Map<String, String>> getUserData() async {
    //creeate an instance for shared pref
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    return {"username": username??"Guest", "email": email??"No Email Found"};
  }

  //remove the username and email from shared preferences
  static Future<void> clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
  }
}
