/*
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'firebase_options.dart';
import 'package:secureeeeeeeeeeeeeeee/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}


class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  bool isInitialized = false;
  List<String> recognizedTextList = [];
  dynamic previousFrame;

  String plate="44444";
  bool match =false;


  @override
  void initState() {
    super.initState();

    fetchDataFromFirestore();


    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );

    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialized = true;
      });


      controller.setFlashMode(FlashMode.off);

      controller.startImageStream((CameraImage image) {
        if (previousFrame != null) {
          _detectMotion(image);
        }
        previousFrame = image;
      });
    });
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('licenseplate') // Replace with your collection name
          .limit(1) // Assuming you want to fetch only one document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<String> plates = [];

        // Iterate through each document and retrieve the 'plate' field
        querySnapshot.docs.forEach((doc) {
          var plate = doc.get('plate') as String?; // Assuming 'plate' is a String field
          if (plate != null) {
            plates.add(plate);
          }
        });

        if (plates.isNotEmpty) {
          print('Plates from Firestore: $plates');
          // Use the plates data wherever needed in your application
        } else {
          print('No plates found in the documents.');
        }
      } else {
        print('No documents found in the collection');
        print(plate);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  int _compareFrames(Uint8List frame1, Uint8List frame2) {
    int changedPixels = 0;

    for (int i = 0; i < frame1.length; i++) {
      if ((frame1[i] - frame2[i]).abs() > 30) {
        changedPixels++;
      }
    }

    return changedPixels;
  }



  void _detectMotion(CameraImage image) async {
    int threshold = 10000; // Adjust this threshold to suit your needs
    int changedPixels = 0;

    for (int i = 0; i < image.planes.length - 1; i++) {
      changedPixels += _compareFrames(
        image.planes[i].bytes,
        previousFrame!.planes[i].bytes,
      );
    }

    if (changedPixels > threshold) {
      final XFile imageFile = await controller.takePicture(); // Capture an image

      final InputImage inputImage = InputImage.fromFilePath(imageFile.path);

      final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognisedText = await textRecognizer.processImage(inputImage);

      List<String> textList = [];

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            textList.add(element.text);
            //  print(element.text);
          }
        }
      }




      if (textList.contains(plate)) {
        print("true");
        setState(() {
          match = true;
        });
      }

      setState(() {
        recognizedTextList = textList;
      });

      textRecognizer.close();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    previousFrame.release(); // Release Mat resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Text Detection App'),
      ),
      body: Column(
        children: [
          CameraPreview(controller),
          SizedBox(height: 16), // Add some space between camera preview and text
          match == true ? Expanded(child: Text(plate, style: TextStyle(fontWeight: FontWeight.bold),)) : Text("no data"),
          Expanded(
            child: ListView.builder(
              itemCount: recognizedTextList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(recognizedTextList[index]),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}

 */