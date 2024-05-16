import 'dart:async';

import 'package:simple_edge_detection_flutter/ffi_edge_detector.dart';

class EdgeDetector {
  Future<EdgeDetectionResult> detectEdges(String filePath) async {
    return EdgeDetection.detectEdges(
      filePath,
    );
  }

  Future<bool> processImage(
      String filePath, EdgeDetectionResult edgeDetectionResult) async {
    return EdgeDetection.processImage(
      filePath,
      edgeDetectionResult,
    );
  }
}
