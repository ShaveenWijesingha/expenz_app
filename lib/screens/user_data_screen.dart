import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:expens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _rememberMe = false;
  //form key for the form validation
  final _formKey = GlobalKey<FormState>();
  //controller for the text form feilds...
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confermPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confermPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(KDefaltPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: kBlack.withOpacity(.82),
                  ),
                ),
                SizedBox(height: KDefaltHeight * 3),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form feild for the user name
                      TextFormField(
                        validator: (value) {
                          //check weather the user enter the valid username...
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                      SizedBox(height: KDefaltHeight * 2),
                      //form feild for the user email
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }

                          // Trim spaces
                          value = value.trim();

                          // Advanced regex
                          final emailRegex = RegExp(
                            r'^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );

                          if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
                          }

                          // Extra rules
                          if (value.startsWith('.')) {
                            return "Email cannot start with '.'";
                          }

                          if (value.endsWith('.')) {
                            return "Email cannot end with '.'";
                          }

                          if (value.contains('..')) {
                            return "Email cannot contain consecutive dots";
                          }

                          if (value.split('@').length != 2) {
                            return "Invalid email format";
                          }

                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                      SizedBox(height: KDefaltHeight * 2),
                      //form feild for the user password
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter password";
                          }
                          if (value.length < 4) {
                            return "Password must be at least 4 characters";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                      SizedBox(height: KDefaltHeight * 2),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the same password";
                          }
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                        },
                        controller: _confermPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),

                      SizedBox(height: KDefaltHeight * 4),

                      //remember me
                      CheckboxListTile(
                        title: Text(
                          "Remember Me for the next time",
                          style: TextStyle(
                            fontSize: 16,
                            color: kBlack.withOpacity(.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      SizedBox(height: 100),
                      //submit Button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //form is valid,process data
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confermPassword =
                                _confermPasswordController.text;
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
