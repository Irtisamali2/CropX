// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/pages/hp.dart';
import 'package:untitled3/routes/myroutes.dart';
// import 'package:untitled3/routes/myroutes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool onChange = false;

  static var error;
  final _formvalidationKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  navigateHomePage(BuildContext conext) async {
    if (_formvalidationKey.currentState!.validate()) {
      setState(() {
        onChange = true;
      });
      await Future.delayed(Duration(seconds: 1));
      // await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        onChange = false;
      });
    }
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      error = e;
      /* _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(
          "$e",
          style: TextStyle(fontSize: 16),
        ),
      ));*/

      // ignore: deprecated_member_use

    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
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
                Text("Welcome To Login Screen $name ",
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
                        controller: _emailController,
                        /*     onChanged: (value) {
                      name = value;
                      setState(() {});
                    },*/
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
                            return error.toString();
                          }
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
                      Row(
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, MyRoutes.signup);
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15,
                                    color: Colors.red),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Ink(
                        child: Material(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            splashColor: Colors.yellow,
                            onTap: () async {
                              User? user = await loginUsingEmailPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                              print(user);
                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => CameraWidget()));
                              }
                              //
                              navigateHomePage(context);

                              // setState(() {});
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
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
