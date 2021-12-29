import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled3/models/usermModel.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = "";
  bool onChange = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ConfirmpasswordController = TextEditingController();

  static var error;
  final _formvalidationKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Form(
            key: _formvalidationKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/login.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Welcome To SignUp Screen $name ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your First Name";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your First Name",
                            labelText: "First Name",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _lastName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Last Name";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your Last Name",
                            labelText: "Last Name",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your Email",
                            labelText: "Email",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (value.length < 7) {
                            return "Please Enter your Password of Atleast 7 alphabets";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _passwordController:
                          value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter your Password",
                            labelText: "Passwprd",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _ConfirmpasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Confirm Password";
                          } else if (value.length < 7) {
                            return "Please Enter your Password of Atleast 7 alphabets";
                            // ignore: unrelated_type_equality_checks
                          }
                          // else if (_ConfirmpasswordController !=
                          //     _passwordController) {
                          //   return "Password doesn't Matched";
                          // else {
                          //   return error.toString();
                          // }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Confirm your Password",
                            labelText: "Confirm Passwprd",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Ink(
                        child: Material(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            splashColor: Colors.yellow,
                            onTap: () async {
                              signUp(_emailController.text,
                                  _passwordController.text);
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: onChange ? 50 : 100,
                              height: 45,
                              alignment: Alignment.center,
                              child: onChange
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formvalidationKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        //Fluttertoast.showToast(msg: e!.message);
        return e.toString();
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.firstName = _firstName.text;
    userModel.lastName = _lastName.text;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created successfully :) ");
  }
}
