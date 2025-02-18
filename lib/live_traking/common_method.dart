

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Common{

  static Future getImage() async {

    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80,maxHeight: 400,maxWidth: 400);

    if (imageFile != null) {
      return imageFile;
    }
    return null;
  }

  ///handles the asset path and receives a size
  ///(this can be either the width, height, or both, but using only one will preserve ratio)
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Future<BitmapDescriptor> setCustomMapPin(String path) async {
    final Uint8List originIcon = await getBytesFromAsset(path, 70);
    return  BitmapDescriptor.fromBytes(originIcon);
  }

}