import 'package:flutter/material.dart';
import 'package:golet/screens/onboarding1.dart';
import 'package:golet/screens/onboarding3.dart';

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Container(
          height: MediaQuery.of(context).size.height / 14,
          decoration: BoxDecoration(
              boxShadow: kElevationToShadow[4], color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Onboarding1())),
                child: Text('   <   PREV',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    )),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Onboarding3())),
                child: Text('NEXT  >   ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    )),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset('assets/onboarding_illustration_2.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 500,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                'Post vacant accomodations and',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 500,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                'connect with a wider audience',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
