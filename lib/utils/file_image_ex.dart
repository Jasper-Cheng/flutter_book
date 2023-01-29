import 'dart:io';

import 'package:flutter/material.dart';

//use this to solve FileImage not change issue. more detail https://www.shuzhiduo.com/A/gAJGyQw0dZ/
class FileImageEx extends FileImage {
  int fileSize=0;
  FileImageEx(File file, { double scale = 1.0 })
      : super(file, scale: scale) {
    fileSize = file.lengthSync();
  }

  @override
  bool operator == (dynamic other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final FileImageEx typedOther = other;
    return file.path == typedOther.file.path
        && scale == typedOther.scale && fileSize == typedOther.fileSize;
  }

}