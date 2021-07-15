import 'package:event_community_organization/model/user_type.dart';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //const
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _dbService = Database();
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  Item? type;

  List<Item> items = <Item>[
    Item('Students', Icon(Icons.accessibility_new_sharp)),
    Item('Organization', Icon(Icons.water_damage_outlined)),
  ];

  void registerSubmitForm() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        final success = await _authService.registerUserWithEmailAndPassword(email!, password!, username!, type!.userType);

        if (success) {
            Navigator.pop(context);
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Register Successful',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green[600],
        ));
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red[600],
        ));
      }
    }
  }

  bool validateEmail(String? email) {
    if (email == null) return true;

    String regex =
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$';
    RegExp validate = RegExp(regex);
    if (!validate.hasMatch(email)) return true;

    return false;
  }

  bool verifyPassword(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) return true;
    if (password.trim() == "" || confirmPassword.trim() == "") return true;
    if (password.length < 6 || confirmPassword.length < 6) return true;
    if (password != confirmPassword) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 18.0,
            color: Colors.blueAccent[700],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Container(
                  child: Text('Logo'),
                ),
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusColor: Colors.blueAccent[700],
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 11, top: 13, right: 20),
                              hintText: 'Please enter your username'),
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Please Enter a valid username'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusColor: Colors.blueAccent[700],
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 11, top: 13, right: 20),
                              hintText: 'Please enter your email'),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) => validateEmail(value)
                              ? 'Please Enter a valid email'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusColor: Colors.blueAccent[700],
                                contentPadding: EdgeInsets.only(
                                    left: 20, bottom: 11, top: 13, right: 20),
                                hintText: 'Please enter your password'),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) => verifyPassword(
                                    password, confirmPassword)
                                ? "Password do not match or must not less than 6"
                                : null),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: TextFormField(
                          obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusColor: Colors.blueAccent[700],
                                contentPadding: EdgeInsets.only(
                                    left: 20, bottom: 11, top: 13, right: 20),
                                hintText: 'Please enter your password'),
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            validator: (value) => verifyPassword(
                                    password, confirmPassword)
                                ? "Password do not match or must not less than 6"
                                : null),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Role:'),
                          DropdownButton(
                            value: type,
                            items: items
                                .map((item) => DropdownMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item.userType),
                                          item.icon,
                                        ],
                                      ),
                                      value: item,
                                    ))
                                .toList(),
                            onChanged: (Item? value) {
                              setState(() {
                                type = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            registerSubmitForm();
                          },
                          child: Text('Register'))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
