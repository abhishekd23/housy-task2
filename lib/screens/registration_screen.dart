import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housy_task_2/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants.dart';
import '../item_list.dart';

Items item = new Items();

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  List _testList = [
    {'no': 1, 'keyword': 'blue'},
    {'no': 2, 'keyword': 'black'},
    {'no': 3, 'keyword': 'red'}
  ];
  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  var _selectedTest;
  bool showSpinner = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPassController = TextEditingController();
  String? professionController;
  final List<String>? names = [];
  final List<String>? email_id = [];
  final List<String>? password = [];
  final List<String>? phone_number = [];
  final List<String>? professions = [];

  String dropdownValue = 'Select Profession';
  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    prefs.setStringList('Names', names!);
    prefs.setStringList('Email', email_id!);
    prefs.setStringList('Password', password!);
    prefs.setStringList('PhoneNumber', phone_number!);
    prefs.setStringList('Profession', professions!);
    print("Successful");
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_testList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Registration Page"),
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
                  CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('images/download.jpg'),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(FontAwesomeIcons.registered),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
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
                        labelText: "Enter your full name",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Enter your mail",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    controller: _phoneController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Enter your phone number",
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
                  TextField(
                    cursorColor: Colors.white,
                    controller: _confirmPassController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Confirm your password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    initialValue: 'Select Profession',
                    //controller: _professionController,
                    labelText: 'Shape',
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    items: item.getList(),
                    onChanged: (val) {
                      setState(
                        () {
                          professionController = val;
                        },
                      );
                    },
                    onSaved: (val) => print(val),
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Select Profession",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: InkWell(
                      onTap: () {
                        final email = _emailController.text.toString().trim();
                        final pass = _passwordController.text.toString().trim();
                        final name = _nameController.text.toString().trim();
                        final phoneno = _phoneController.text.toString().trim();
                        final profession =
                            professionController!.toString().trim();
                        if (_nameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPassController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            profession.isNotEmpty) {
                          if (_confirmPassController.text.trim() !=
                              _passwordController.text.trim()) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: "Passwords do not match!",
                              ),
                            );
                          } else {
                            names!.add(name);
                            email_id!.add(email);
                            phone_number!.add(phoneno);
                            password!.add(pass);
                            professions!.add(profession);

                            setData();
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: "Successfully Registered!",
                              ),
                            );
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomePage(),
                                ),
                              );
                            });
                          }
                        } else {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: "Please fill the necessary information!",
                            ),
                          );
                        }
                      },
                      child: new Container(
                        width: 150.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border:
                              new Border.all(color: Colors.white, width: 2.0),
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
