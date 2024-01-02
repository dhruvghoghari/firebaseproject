import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/EditEmploye.dart';
import 'package:firebaseproject/googleads/ViewProducts.dart';
// import 'package:firebaseproject/animation/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'AddEmploye.dart';
import 'Addproduct.dart';
import 'googleads/GoogleAdsExample.dart';
import 'googlemap/CurrentLocationScreen.dart';
import 'googlemap/GoogleMapExample.dart';
import 'HomeScreen.dart';
import 'ViewProduct.dart';
import 'firebase_options.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
