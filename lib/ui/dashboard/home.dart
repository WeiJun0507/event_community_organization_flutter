import 'package:event_community_organization/ui/dashboard/BottomNavigationBar.dart';
import 'package:event_community_organization/ui/event/event_dashboard.dart';
import 'package:event_community_organization/ui/post/post_screen.dart';
import 'package:event_community_organization/ui/profile/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedPage =0;

  final List pages= [
    PostScreen(),
    EventDashboard(),
    Profile(),
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
