import 'package:firebaseproject/AddEmploye.dart';
import 'package:firebaseproject/Addproduct.dart';
import 'package:firebaseproject/GoogleMapExample.dart';
import 'package:firebaseproject/OnlinePayment.dart';
import 'package:firebaseproject/ViewEmploye.dart';
import 'package:firebaseproject/ViewProduct.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FirebaseExample"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text("Add Product"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("View Product"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewProduct()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("Add Employ"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEmploy()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("View Employ"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewEmploye()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("OnlinePayment"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OnlinePayment()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("GoogleMap"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GoogleMapExample()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
