import 'package:event_community_organization/ui/authenticate_ui/login.dart';
import 'package:event_community_organization/ui/event/event_dashboard.dart';
import 'package:event_community_organization/ui/event/event_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    return user != null ? Home() : LoginPage();
  }
}
