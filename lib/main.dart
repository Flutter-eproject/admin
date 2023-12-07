import 'dart:async';

import 'package:admin/Firebase_auth/ad-reg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Firebase_auth/ad_login.dart';
import 'Product_insert_Screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminSplashScreen(),
    );
  }
}


class AdminSplashScreen extends StatefulWidget {
  const AdminSplashScreen({super.key});

  @override
  State<AdminSplashScreen> createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(milliseconds: 5000),
            () => FirebaseAuth.instance.currentUser != null
            ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>insertScreen(),
            ))
            : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>loginscreen(),
            )));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(image: AssetImage('assets/images/admin1stpic.jpeg'))
              ),

            ),


            SizedBox(height: 30,),

            Text("Admin",style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700
            ),),


            Container(
              margin: EdgeInsets.only(left: 30,right: 10),
              child: Text("making your business processes seamless ",style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
