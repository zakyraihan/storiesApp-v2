import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Image.asset('assets/img/logo-removebg-preview.png'),
            ),
            const Text(
              'Dicoding Indonesia',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
