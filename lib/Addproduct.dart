import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  final ImagePicker picker = ImagePicker();
  var isloading=false;

  File? selectedfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade100,
              child: (isloading==true)?Center(
                child: CircularProgressIndicator(),
              ):SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Add Product",style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),),
                      (selectedfile==null)?Image.asset("img/Apple.jpg"):Image.file(selectedfile!,width: 100.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () async{
                              final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                              setState(() {
                                selectedfile = File(photo!.path);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_library_outlined),
                            onPressed: () async{
                              final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
                              setState(() {
                                selectedfile = File(photo!.path);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.video_call),
                            onPressed: () async{
                                final XFile? galleryVideo = await picker.pickVideo(source: ImageSource.gallery);
                                  setState(() {
                                    selectedfile = File(galleryVideo!.path);
                                  });
                              }
                          )
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Name :-",style: TextStyle(
                            fontSize: 30.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _name,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Price :-",style: TextStyle(
                            fontSize: 30.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _price,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Qty :-",style: TextStyle(
                            fontSize: 30.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _quantity,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50.0,
                            width: 150.0,
                            child: ElevatedButton(
                              onPressed: ()  async{


                                setState(() {
                                  isloading=true;
                                });


                                var nm = _name.text.toString();
                                var qty = _quantity.text.toString();
                                var price = _price.text.toString();

                                var uuid = Uuid();
                                var filename = uuid.v1();


                                await FirebaseStorage.instance.ref(filename).putFile(selectedfile!)
                                    .whenComplete((){}).then((filedata) async{

                                      await filedata.ref.getDownloadURL().then((fileurl) async{

                                        await FirebaseFirestore.instance.collection("Product").add({
                                          "name":nm,
                                          "qty":qty,
                                          "price":price,
                                          "filename":filename,
                                          "fileurl":fileurl
                                        }).then((value){
                                          print("Insert Successfully");
                                          setState(() {
                                            isloading=false;
                                          });
                                          _name.text="";
                                          _quantity.text="";
                                          _price.text="";
                                          setState(() {
                                            selectedfile=null;
                                          });
                                        });
                                      });
                                });





                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              ),
                              child: Text("ADD ➕",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ],
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
