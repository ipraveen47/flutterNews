import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Material(
                elevation: 3.0,
                child: Image.asset(
                  "assets/building.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "News from all Over the World \n           Curated for You ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'TwinkleStar-Regular.ttf'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Stay connect with the real world \n      happenings so you \n          don't miss anything ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
