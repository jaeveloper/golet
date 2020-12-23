import 'package:flutter/material.dart';
import 'package:golet/services/auth_service.dart';

class HomePgeScreen extends StatefulWidget {
  @override
  _HomePgeScreenState createState() => _HomePgeScreenState();
}

class _HomePgeScreenState extends State<HomePgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Title(
          color: Colors.white,
          child: Image.asset(
            'assets/inhabitants_logo.png',
            scale: 8,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(child: InkWell(
        onTap: () => AuthService.logout(context),
        child: Text('home'))),
    );
  }
}
