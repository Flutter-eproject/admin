import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class insertScreen extends StatefulWidget {
  const insertScreen({super.key});

  @override
  State<insertScreen> createState() => _insertScreenState();
}

class _insertScreenState extends State<insertScreen> {

  TextEditingController Name=TextEditingController();
  TextEditingController Brand=TextEditingController();
  TextEditingController Price=TextEditingController();
  TextEditingController Memory=TextEditingController();
  TextEditingController operatingSystem=TextEditingController();
  TextEditingController Processor=TextEditingController();
  TextEditingController Display=TextEditingController();
  TextEditingController powerSupply=TextEditingController();
  TextEditingController Battery=TextEditingController();
  TextEditingController Storage=TextEditingController();



  File? productImage;

  void InsertProductwithImg()async{

    UploadTask uploadTask = FirebaseStorage.instance.ref().child("Product-Images").child(Uuid().v1()).putFile(productImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String Image = await taskSnapshot.ref.getDownloadURL();
    InsertProduct(imgURL: Image);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Inserted(),));

  }

  void InsertProduct ({String? imgURL})async{

    String productId = Uuid().v1();

    Map<String , dynamic> productDetails ={
      "Product-Id":productId,
      "Product-Image": imgURL,
      "Product-Name":Name.text.toString(),
      "Product-Brand":Brand.text.toString(),
      "Product-Price":Price.text.toString(),
      "Product-Memory":Memory.text.toString(),
      "Product-operatingSystem":operatingSystem.text.toString(),
      "Product-Processor":Processor.text.toString(),
      "Product-Display":Display.text.toString(),
      "Product-powerSupply":powerSupply.text.toString(),
      "Product-Battery":Battery.text.toString(),
      "Product-Storage":Storage.text.toString(),

    };

    FirebaseFirestore.instance.collection("Product-Data").doc(productId).set(productDetails);

  }
  var _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    Name.dispose();
    Brand.dispose();
    Price.dispose();
    Memory.dispose();
    operatingSystem.dispose();
    Processor.dispose();
    Display.dispose();
    powerSupply.dispose();
    Battery.dispose();
    Storage.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 40, top: 80),
              child: Text("INSERT LAPTOPS" , style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF040B2D)
              ),),
            ),
            Column(
              children: [
                      Stack(
                        children: [
                        Container(
                          margin: EdgeInsets.only(left: 30 , top: 30),
                          width: 350,
                          height: 900,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF040B2D),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(9, 8), // Shadow position
                              ),
                            ],
                          ),
                        ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [

                                SizedBox(height: 20,),

                                GestureDetector(
                                  onTap: () async {
                                    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    if (selectedImage!=null) {
                                      File convertedFile  =File(selectedImage.path);
                                      setState(() {
                                        productImage = convertedFile;
                                      });
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey.shade400,
                                    backgroundImage: productImage!=null?FileImage(productImage!):null,
                                  ),
                                ),

                                SizedBox(height: 20,),
                                Container(
                                  width: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Name,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "ProductName is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Product name"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height: 20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Brand,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "Brand Name is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Brand name"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height: 20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Price,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "price is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Price"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Memory,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "Memory is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Laptop's Memory"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: operatingSystem,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "Operating System is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Operating System"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Processor,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "Processor is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Processor "),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Display,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return " Display is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Display"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),
                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: powerSupply,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return " Power Supply  is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Power Supply"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),
                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Battery,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return " Battery is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Battery"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),
                                Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal:20),
                                    child:TextFormField(
                                        controller: Storage,
                                        validator: (value){
                                          if (value==null || value.isEmpty || value==" ") {
                                            return "Storage is required ";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          label: Text("Enter Storage"),
                                          border: OutlineInputBorder(

                                            borderSide: BorderSide(
                                                color: Colors.lime
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                        )
                                    )
                                ),

                                SizedBox(height:20,),

                                ElevatedButton(onPressed: (){

                                  if (_formkey.currentState!.validate()) {

                                    InsertProductwithImg();

                                  }
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Inserted(),));
                                },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xffffffff)),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                                    width: 350,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xf0000523),
                                      border: Border.all(color: Color(0xffffffff),width: 3),
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4,vertical:1 ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 120,),
                                          Text("Insert", style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              color:  Color(0xffffffff)
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),

                              ],
                            ),
                          ),





    ]
                            ),
    ]


                          ),
                ],

                      )


            )

        );




  }
}
