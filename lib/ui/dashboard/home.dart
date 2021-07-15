import 'package:event_community_organization/provider.dart';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/ui/dashboard/BottomNavigationBar.dart';
import 'package:event_community_organization/ui/event/event_dashboard.dart';
import 'package:event_community_organization/ui/post/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final _authService = AuthService();
  final _dbService = Database();

  late String userType;


  @override
  void initState() {
    identifyUserType();
    super.initState();
  }

  void identifyUserType() async {
    final result = await _dbService.getUserProfile(_auth.currentUser!.uid);
    setState(() {
      userType = result!.userType;
    });
  }

  int _selectedPage =0;

  final List pages= [
    PostScreen(),
    EventDashboard(),
    null,
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: CustomBottomNavigationBar(
        onChange: (val){
          setState(() {
            _selectedPage = val;
          });
        },
        defaultSelectedIndex:0,
      ),

    );
  }
}
