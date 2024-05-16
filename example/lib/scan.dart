import 'dart:async';
import 'dart:developer';

import 'package:simple_edge_detection_flutter/ffi_edge_detector.dart';
import 'package:simple_edge_detection_flutter/simple_edge_detection_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_view.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String? imagePath;
  String? croppedImagePath;
  EdgeDetectionResult? edgeDetectionResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getMainWidget(),
          _getBottomBar(),
        ],
      ),
    );
  }

  Widget _getMainWidget() {
    if (croppedImagePath != null) {
      return ImageView(
        imagePath: croppedImagePath!,
      );
    }

    if (imagePath == null || edgeDetectionResult == null) return Container();
    return ImagePreview(
      imagePath: imagePath!,
      edgeDetectionResult: edgeDetectionResult!,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getButtonRow() {
    if (imagePath != null) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            if (croppedImagePath == null && imagePath != null) {
              _processImage(imagePath!, edgeDetectionResult!);
            }

            setState(() {});
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          foregroundColor: Colors.white,
          onPressed: onTakePictureButtonPressed,
          child: const Icon(Icons.camera_alt),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          foregroundColor: Colors.white,
          onPressed: _onGalleryButtonPressed,
          child: const Icon(Icons.image),
        ),
      ],
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> takePicture() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    return file?.path;
  }

  Future _detectEdges(String filePath) async {
    if (!mounted) {
      return;
    }

    setState(() {
      imagePath = filePath;
    });

    EdgeDetectionResult result = await EdgeDetector().detectEdges(
      filePath,
    );

    setState(() {
      edgeDetectionResult = result;
    });
  }

  _processImage(
      String filePath, EdgeDetectionResult edgeDetectionResult) async {
    if (!mounted) {
      return;
    }

    bool result = await EdgeDetector().processImage(
      filePath,
      edgeDetectionResult,
    );

    if (result == false) {
      return;
    }

    setState(() {
      imageCache.clearLiveImages();
      imageCache.clear();
      croppedImagePath = imagePath;
    });
  }

  void onTakePictureButtonPressed() async {
    String? filePath = await takePicture();

    log('Picture saved to $filePath');

    await _detectEdges(filePath!);
  }

  void _onGalleryButtonPressed() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final filePath = pickedFile!.path;

    log('Picture saved to $filePath');

    _detectEdges(filePath);
  }

  Padding _getBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: _getButtonRow(),
      ),
    );
  }
}
