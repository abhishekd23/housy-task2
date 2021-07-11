import 'package:flutter/material.dart';
import 'package:housy_task_2/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String>? names = [];
  List<String>? email_id = [];
  List<String>? password = [];
  List<String>? phone_number = [];
  List<String>? professions = [];
  int? count;
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    names = prefs.getStringList('Names');
    email_id = prefs.getStringList('Email');
    password = prefs.getStringList('Password');
    phone_number = prefs.getStringList('PhoneNumber');
    professions = prefs.getStringList('Profession');
    if (names == null ||
        email_id == null ||
        password == null ||
        phone_number == null ||
        professions == null) {
      names = ['Enter Your Name'];
      email_id = ['Enter Your email'];
      password = ['Enter Your password'];
      phone_number = ['Enter your phone number'];
      professions = ['Enter Your profession'];
    }
    count = names!.length;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen(
            names: names,
            email_id: email_id,
            password: password,
            phone_number: phone_number,
            professions: professions,
            num: count,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Welcome!"),
        ),
        backgroundColor: Color(0xFFF1C085),
      ),
      backgroundColor: Color(0xFFF1C085),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage('images/download.jpg'),
          ),
          SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => getData(),
                child: new Container(
                  width: 150.0,
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
              InkWell(
                onTap: () => Navigator.pushNamed(context, REGISTRATION_SCREEN),
                child: new Container(
                  width: 150.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  child: new Center(
                    child: new Text(
                      'Register',
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
        ]),
      ),
    );
  }
}
