import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecordScanner extends StatefulWidget {
  const RecordScanner({super.key});

  @override
  State<RecordScanner> createState() => _RecordScannerState();
}

class _RecordScannerState extends State<RecordScanner> {
  File? selectedMedia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(
              context: context, singleMedia: true);
          if (media != null && media.isNotEmpty) {
            var data = await media.first.getFile();
            setState(() {
              selectedMedia = data;
            });
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget _buildUI() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageView(),
          ],
        ),
      ),
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text("Add image of your records to be scanned"),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
      ),
    );
  }

  // Widget _extractTextView() {
  //   if (selectedMedia == null) {
  //     return const Center(
  //       child: Text("No result."),
  //     );
  //   }
  //   return FutureBuilder(
  //     future: _extractText(selectedMedia!),
  //     builder: (context, snapshot) {
  //       return Text(
  //         snapshot.data ?? "",
  //         style: const TextStyle(
  //           fontSize: 25,
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }
}
