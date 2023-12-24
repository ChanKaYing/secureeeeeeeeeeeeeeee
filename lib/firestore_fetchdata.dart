
import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:secureeeeeeeeeeeeeeee/firebase_options.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secureeeeeeeeeeeeeeee/result_sreen.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'License Plates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String fetchedData = '';

  Future<void> fetchData() async {
    try {
      // Fetching data from the 'licenseplate' collection
      QuerySnapshot querySnapshot = await _firestore.collection('licenseplate').get();
      setState(() {
        fetchedData = '';
        for (var doc in querySnapshot.docs) {
          // Accessing the 'plate' field from each document
          var plate = doc['plate'];
          fetchedData += 'Plate: $plate\n';
        }
      });
    } catch (e) {
      setState(() {
        fetchedData = 'Error fetching data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('License Plates'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              fetchedData.isNotEmpty ? fetchedData : 'Press button to fetch data',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch License Plates'),
            ),
          ],
        ),
      ),
    );
  }
}

