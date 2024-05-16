import 'dart:io';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  GlobalKey imageWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext mainContext) {
    return Center(
      child: Image.file(
        File(
          widget.imagePath,
        ),
        fit: BoxFit.contain,
      ),
    );
  }
}
