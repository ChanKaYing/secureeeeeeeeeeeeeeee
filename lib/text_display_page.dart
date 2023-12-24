import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LicensePlateScreen extends StatelessWidget {
  // Initialize Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getData() async {
    try {
      // Access 'licenseplate' collection
      QuerySnapshot querySnapshot = await firestore.collection('licenseplate').get();

      // Loop through documents
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Get the 'plate' field from each document
        dynamic plate = doc.get('plate');

        // Perform actions with the 'plate' data
        print('License Plate: $plate');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('License Plates'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the function to get data
            getData();
          },
          child: Text('Get License Plates'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LicensePlateScreen(),
  ));
}
