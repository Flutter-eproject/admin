import 'package:admin/Product_Insert_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void AdimnLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => insertScreen(),));
      SharedPreferences adminEmail = await SharedPreferences.getInstance();
      adminEmail.setString("Admin-Email", email.text.toString());
    } on FirebaseAuthException catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${ex.code.toString()}")));
    }
  }
  bool passHide = true;

  var _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Text("Hello Again!",style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text("Welcome Back You've",style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text("Been Missed",style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),

            SizedBox(height: 60,),

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
                      AdimnLogin();

                      if(_formkey.currentState!.validate()){
                        print(email.text.toString());
                        print(password.text.toString());
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Admin Login"),
                            content: const Text("Login Successfull!"),
                            actions: [
                              ElevatedButton(onPressed: (){
                                AdimnLogin();

                              }, child: const Text("Login")),
                              OutlinedButton(onPressed: (){
                              }, child: const Text("Cancel"))
                            ],
                          );
                        });
                      }
                    }, child: Container(
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
                    child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 30), ),
                  ),
                )
                )

              ],
            ),








          ],
        ),
      ),

    );
  }
}
