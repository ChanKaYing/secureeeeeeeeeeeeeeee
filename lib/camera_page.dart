/*
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraPage({Key? key, required this.cameras}) : super(key: key);

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
  bool isProcessingPicture = false;
  List<String> recognizedTextList = [];
  dynamic previousFrame;

  @override
  void initState() {
    super.initState();

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
        if (previousFrame != null && !isProcessingPicture) {
          _detectMotion(image);
        }
        previousFrame = image;
      });
    });
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
      try {
        isProcessingPicture = true; // Set the flag before taking a picture
        final XFile imageFile = await controller.takePicture();

        final InputImage inputImage = InputImage.fromFilePath(imageFile.path);

        final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();
        final RecognizedText recognisedText = await textRecognizer.processImage(inputImage);

        List<String> textList = [];

        for (TextBlock block in recognisedText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement element in line.elements) {
              textList.add(element.text);
              print(element.text);
            }
          }
        }

        setState(() {
          recognizedTextList = textList;
        });

        textRecognizer.close();
      } catch (e) {
        print("Error processing image: $e");
      } finally {
        isProcessingPicture = false; // Reset the flag after processing is complete
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    if (previousFrame != null) {
      previousFrame.release(); // Release Mat resources if previousFrame is not null
    }
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