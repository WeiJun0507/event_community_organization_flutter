import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/ui/profile/Member.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[400],
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 70,
          // ),
          Container(
            height: 280,
            color: Colors.teal[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Name:",
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: 20),
                Text(
                  'John',
                  style: TextStyle(
                    color: Colors.teal[400],
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MemberDetail()));
              },
              child: Row(
                children: [
                  Icon(Icons.quick_contacts_mail_outlined, color: Colors.teal[400]),
                  // Icons.person_outline_outlined
                  SizedBox(width: 30),
                  Expanded(
                    child: Text("Member Detail"),
                  ),
                  Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              onPressed: () {
                _authService.logout();
              },
              child: Row(
                children: [
                  Icon(Icons.directions_run_outlined, color: Colors.teal[400]),
                  // Icons.person_outline_outlined
                  SizedBox(width: 30),
                  Expanded(
                    child: Text("Logout"),
                  ),
                  Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
