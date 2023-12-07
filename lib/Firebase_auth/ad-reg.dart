import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'ad_login.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void AdminRegInsert()async{
    String userId = Uuid().v1();
    Map<String, dynamic> adminDetail = {
      "Admin-Id": userId,
      "Admin-Name": name.text.toString(),
      "Admin-Email": email.text.toString(),
      "Admin-Contact": contact.text.toString(),
      "Admin-Password": password.text.toString(),
    };
    FirebaseFirestore.instance.collection("adminData").doc(userId).set(adminDetail);
  }

  bool passHide = true;

  var _formkey = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    contact.dispose();
    password.dispose();
  }


  @override
  Widget build(BuildContext context) {
    void createUser()async{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
      } on FirebaseAuthException catch(ex){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${ex.code.toString()}")));
      }
    }
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [


            Center(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Text("Register!",style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text("Register effortlessly with us",style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(" on your side.",style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),


            SizedBox(height: 40),


            Form(
              key: _formkey,

              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFC9C8C8),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                    ),
                    child: TextFormField(
                      controller: name,
                      validator: (value){
                        if(value == null || value.isEmpty || value == " "){
                          return "Name is Required";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline_outlined),
                        labelText: 'Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14, top: 8, bottom: 8),
                      ),
                    ),

                  ),

                  SizedBox(height: 20),

                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFC9C8C8),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                    ),
                    child: TextFormField(
                      controller: contact,
                      validator: (value){
                        if(value == null || value.isEmpty || value == " "){
                          return "Contact Number";
                        }
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_rounded),
                        labelText: 'Number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14, top: 8, bottom: 8),
                      ),
                    ),

                  ),

                  SizedBox(height: 20),


                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFC9C8C8),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                    ),
                    child: TextFormField(
                      controller: email,
                      validator: (value){
                        if(value == null || value.isEmpty || value == " "){
                          return "Email is Required";
                        }
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_lock),
                        labelText: 'Email',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14, top: 8, bottom: 8),
                      ),
                    ),

                  ),

                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFC9C8C8),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                    ),
                    child: TextFormField(
                      controller: password,
                      validator: (value){
                        if(value == null || value.isEmpty || value == " "){
                          return "Password is Required";
                        }
                      },
                      obscureText: passHide==true?true:false,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        labelText: 'Password',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14, top: 8, bottom: 8),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            passHide =! passHide;
                          });
                        }, icon: passHide==true? Icon(Icons.remove_red_eye):Icon(Icons.key)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),



                ],
              ),

            ),

            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    createUser();
                    AdminRegInsert();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return loginscreen();
                      },
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20 , top: 20,right: 20),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: [
                              Colors.black,
                              Color(0xFF040B2D),
                              Colors.black
                            ]
                        )
                    ),
                    child: const Center(
                      child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 30), ),
                    ),
                  ),
                )


              ],
            ),





          ],

        ),
      ),



    );
  }
}

