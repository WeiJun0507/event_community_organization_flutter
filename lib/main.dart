import 'package:event_community_organization/provider.dart';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/ui/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Organization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          StreamProvider<User?>.value(value: _authService.user, initialData: null,),
          ChangeNotifierProvider.value(value: MMber()),
        ],
        child: Wrapper(),
      ),
    );
  }
}