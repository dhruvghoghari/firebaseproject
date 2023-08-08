import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddEmploy extends StatefulWidget {
  const AddEmploy({Key? key}) : super(key: key);

  @override
  State<AddEmploy> createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat("dd-MM-yyyy").format(pickedDate);
      setState(() {
        selectedDate = pickedDate;
        _date.text = formattedDate.toString();
      });
    }
  }



  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _date = TextEditingController();

  final ImagePicker picker = ImagePicker();

  File? selectedfile;
  var isloading=false;

  var gender="f";
  var department="sale";

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
                      Text("Add Employ",style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),),

                      (selectedfile==null)?Image.asset("img/emplye.jpg"):Image.file(selectedfile!,width: 200.0,height: 200.0,),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox.fromSize(
                            size: Size(56, 56),
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () async{
                                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      selectedfile = File(image!.path);
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.person_add_alt_1_outlined),
                                      Text("Profile"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox.fromSize(
                            size: Size(56, 56),
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () async {
                                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                    setState(() {
                                      selectedfile = File(image!.path);
                                    });

                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.camera_alt),
                                      Text("Camera"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox.fromSize(
                            size: Size(56, 56),
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () async{
                                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      selectedfile = File(image!.path);
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.photo),
                                      Text("Gallery"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Salary :-",style: TextStyle(
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
                          controller: _salary,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      //  Gender
                      Row(
                        children: [
                          Text("Gender"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            groupValue: gender,
                            value: "M",
                            onChanged:(val){
                              setState(() {
                                gender=val!;
                              });
                            },
                          ),
                          Text("Male"),
                          Radio(
                            groupValue: gender,
                            value: "F",
                            onChanged: (val){
                              setState(() {
                                gender=val!;
                              });
                            },
                          ),
                          Text("Female")
                        ],
                      ),

                      // Department
                      Row(
                        children: [
                          Text("Department")
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            value: department,
                            onChanged: (val)
                            {
                              setState(() {
                                department=val!;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text("Sale"),
                                value: "sale",
                              ),
                              DropdownMenuItem(
                                child: Text("Purchase"),
                                value: "pr",
                              ),
                              DropdownMenuItem(
                                child: Text("Profit"),
                                value: "pt",
                              ),
                              DropdownMenuItem(
                                child: Text("pf"),
                                value: "pf",
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Date :-",style: TextStyle(
                            fontSize: 30.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: (){
                                _selectDate(context);
                              },
                              icon: Icon(Icons.date_range_sharp),
                            ),
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _date,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: ElevatedButton(
                          onPressed: () async{

                            setState(() {
                              isloading=true;
                            });


                            var nm = _name.text.toString();
                            var sal = _salary.text.toString();
                            var gr = gender.toString();
                            var dp = department.toString();
                            var dt = _date.text.toString();

                            var uuid = Uuid();
                            var filename = uuid.v1();
                            await FirebaseStorage.instance.ref(filename).putFile(selectedfile!)
                                .whenComplete((){}).then((filedata) async{

                              await filedata.ref.getDownloadURL().then((fileurl)async{

                                await FirebaseFirestore.instance.collection("Employe").add({
                                  "name":nm,
                                  "salary":sal,
                                  "gender":gr,
                                  "department":dp,
                                  "date":dt,
                                  "filename":filename,
                                  "fileurl":fileurl
                                }).then((value) {
                                  var snackbar = SnackBar(
                                    content: Text("Insert Data Successfully"),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  _name.text="";
                                  _salary.text="";
                                  gender="f";
                                  department="sale";
                                  _date.text="";
                                  setState(() {
                                    selectedfile=null;
                                    isloading=false;
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
