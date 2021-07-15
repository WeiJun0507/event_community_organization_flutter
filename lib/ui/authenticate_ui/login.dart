import 'package:event_community_organization/provider.dart';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/ui/authenticate_ui/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _authService = AuthService();
  final _dbService = Database();

  late String email;
  late String password;

  bool validateEmail(email) {
    String regex =
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$';
    RegExp validate = RegExp(regex);
    if (!validate.hasMatch(email)) return true;

    return false;
  }

  void _signInSubmitForm() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        _authService.signInUserWithEmailAndPassword(email, password);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Login Successful',
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.07,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RegisterPage()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250.0,
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Text('LOGO'),
                  ),
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
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Please enter your email'),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) => validateEmail(value!)
                              ? 'Please Enter a valid email'
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Please enter your password'),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value == null) return 'password cannot be empty';
                          if (value.length < 6)
                            return 'password cannot be less than 6 characters';
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(120.0, 40.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                          onPressed: () {

                            _signInSubmitForm();
                          },
                          child: Text('Submit')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
