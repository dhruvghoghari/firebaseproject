import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/AddEmploye.dart';
import 'package:firebaseproject/EditEmploye.dart';
import 'package:flutter/material.dart';

class ViewEmploye extends StatefulWidget {
  const ViewEmploye({Key? key}) : super(key: key);

  @override
  State<ViewEmploye> createState() => _ViewEmployeState();
}

class _ViewEmployeState extends State<ViewEmploye> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Employe").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
              {
                if(snapshot.data!.size<=0)
                  {
                    return Center(
                      child: Image.asset("img/Nodata.jpg"),
                    );
                  }
                else
                  {
                    return ListView(
                      children: snapshot.data!.docs.map((document){
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.green.shade900)
                          ),
                          child: Column(
                            children: [
                              Image.network(document["fileurl"].toString()),
                              Text("Name :"+document["name"].toString()),
                              Text("gender :"+document["gender"].toString()),
                              Text("department :"+document["department"].toString()),
                              Text("Rs."+document["salary"].toString()),
                              Text("Date :"+document["date"].toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      var id = document.id.toString();

                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => EditEmploye(
                                          updateid: id,
                                        )),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      onPrimary: Colors.white,
                                    ),
                                    child: Text("Edit"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      var id = document.id.toString();

                                      // SHOW THE ALERT DIALOGUE
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Row(
                                              children: [
                                                Image.asset("img/Alert.png", height: 50.0, width: 50.0),
                                                SizedBox(width: 10.0),
                                                Text("Confirm Delete"),
                                              ],
                                            ),
                                            content: Text("Are you sure want to delete this item?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();

                                                  await FirebaseFirestore.instance.collection("Employe").doc(id).delete().then((value) {
                                                    var snackbar = SnackBar(
                                                      content: Text("Delete Successfully"),
                                                      duration: Duration(seconds: 2),
                                                      backgroundColor: Colors.red,
                                                    );
                                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                  });
                                                },
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      onPrimary: Colors.white,
                                    ),
                                    child: Text("Delete"),
                                  )

                                ],
                              ),
                            ],
                          )
                        );
                      }).toList(),
                    );
                  }
              }
            else
              {
                return Center(
                  child: Image.asset("img/Load.jpg"),
                );
              }
          }
        )
      ),
    );
  }
}
