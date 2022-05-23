import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class PowerTextureImageInfo extends PowerImageInfo {
  static ui.Image? dummy;

  final int? textureId;
  final int? width;
  final int? height;

  int get sizeBytes => width! * height! * 4;

  PowerTextureImageInfo(
      {this.textureId,
      this.width,
      this.height,
      required ui.Image image,
      double scale = 1.0,
      String? debugLabel})
      : super(image: image, scale: scale, debugLabel: debugLabel);

  ImageInfo clone() {
    return PowerTextureImageInfo(
      image: image.clone(),
      textureId: textureId,
      width: width,
      height: height,
      scale: scale,
      debugLabel: debugLabel,
    );
  }

  static FutureOr<PowerTextureImageInfo> create(
      {int? textureId, int? width, int? height}) async {
    if (dummy != null) {
      return PowerTextureImageInfo(
          textureId: textureId,
          width: width,
          height: height,
          image: dummy!.clone());
    }

    dummy = await _createImage(1, 1);
    return PowerTextureImageInfo(
        textureId: textureId,
        width: width,
        height: height,
        image: dummy!.clone());
  }
}

Future<ui.Image> _createImage(int width, int height) async {
  final Completer<ui.Image> completer = Completer<ui.Image>();
  ui.decodeImageFromPixels(
    Uint8List.fromList(
        List<int>.filled(width * height * 4, 0, growable: false)),
    width,
    height,
    ui.PixelFormat.rgba8888,
    (ui.Image image) {
      completer.complete(image);
    },
  );
  return completer.future;
}

class PowerImageInfo extends ImageInfo {
  PowerImageInfo({required ui.Image image, double scale = 1.0, String? debugLabel})
      : super(image: image, scale: scale, debugLabel: debugLabel);

  ImageInfo clone() {
    return PowerImageInfo(
      image: image.clone(),
      scale: scale,
      debugLabel: debugLabel,
    );
  }
}
