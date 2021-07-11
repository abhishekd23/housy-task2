import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housy_task_2/screens/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(
      {this.names,
      this.email_id,
      this.password,
      this.phone_number,
      this.professions,
      this.num});

  final List<String>? names;
  final List<String>? email_id;
  final List<String>? password;
  final List<String>? phone_number;
  final List<String>? professions;
  final int? num;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;
  int? position;
  bool? flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Login Page"),
        backgroundColor: Color(0xFFF1C085).withOpacity(0.5),
      ),
      backgroundColor: Color(0xFFF1C085),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 0.4,
        //color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          FontAwesomeIcons.signInAlt,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Enter your name",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Enter your password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      final name = _nameController.text.toString().trim();
                      final password =
                          _passwordController.text.toString().trim();
                      for (int i = 0; i < widget.num!; i++) {
                        if (name == widget.names![i]) {
                          position = i;
                          flag = true;
                          break;
                        }
                      }
                      if (flag == true) {
                        if (widget.password![position!] == password) {
                          setState(() {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: "Log In successful !",
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          });
                        } else {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Invalid Credentials",
                            ),
                          );
                        }
                      }
                    },
                    child: new Container(
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: new Center(
                        child: new Text(
                          'Login',
                          style: new TextStyle(
                              fontSize: 25.0,
                              color: Color(0xFFF1C085),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
