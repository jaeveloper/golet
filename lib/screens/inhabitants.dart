import 'package:flutter/material.dart';
import 'package:golet/screens/onboarding1.dart';

class Inhabitants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width/1,
                height: MediaQuery.of(context).size.height / 4,
                child: Image.asset('assets/illustration_estate.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 500,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /1.2,
              height: MediaQuery.of(context).size.height / 15,
              child: Image.asset('assets/inhabitants_logo.png'),
            ),
             SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 20,
                  child: FlatButton(
                    onPressed: 
                     () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Onboarding1())),
                    child: Text(
                      'Next >',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
