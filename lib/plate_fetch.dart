import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDataPage extends StatefulWidget {
  @override
  _FetchDataPageState createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  List<String> fetchedTextList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('licenseplate').get();

      List<String> texts = [];
      querySnapshot.docs.forEach((doc) {
        final plate = doc.get('plate');
        if (plate != null && plate is String) {
          texts.add(plate);
        }
      });

      setState(() {
        fetchedTextList = texts;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data'),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Display a loader while fetching data
      ),
    );
  }
}
