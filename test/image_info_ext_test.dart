// import 'package:flutter/src/painting/image_provider.dart';
// import 'package:flutter/src/painting/image_stream.dart';
import 'dart:typed_data';
import 'dart:ui' as ui show Codec;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_image_ext/image_cache_ext.dart';
import 'package:power_image_ext/image_info_ext.dart';
import 'package:power_image_ext/image_provider_ext.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('PowerTextureImageInfo', () {
    setUp(() {});

    test('dummy', () async {
      expect(PowerTextureImageInfo.dummy == null, true);
      PowerTextureImageInfo imageInfo = await PowerTextureImageInfo.create(textureId: 1, width: 10, height: 20);
      expect(PowerTextureImageInfo.dummy != null, true);
      expect(imageInfo.textureId == 1, true);
      expect(imageInfo.width == 10, true);
      expect(imageInfo.height == 20, true);
      expect(imageInfo.image.width == 1, true);
      expect(imageInfo.image.height == 1, true);
    });
  });
}
