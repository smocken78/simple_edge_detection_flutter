# simple_edge_detection_flutter

A simple edge detection plugin utilizing OpenCV
This is mostly a copy of https://github.com/flutter-clutter/flutter-simple-edge-detection


## Usage
If you just want to test it, go ahead and clone this repository. Before you can run the example, you need to download the OpenCV library. Download the iOS pack and Android on https://opencv.org/releases/. Afterwards, copy the respective files into the directory of this plugin where project_root is the root folder of this plugin:

# OpenCV for Android
```
cp -R sdk/native/jni/include project_root
cp -R sdk/native/libs/* project_root/android/src/main/jniLibs/*
```
# OpenCV for iOS
```
cp -R opencv2.framework project_root/ios
```
