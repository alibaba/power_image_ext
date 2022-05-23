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
import 'package:power_image_ext/remove_aware_map.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('RemoveAwareMap', () {
    setUp(() {});

    test('hasRemovedCallback', () async {
      RemoveAwareMap<String, String> map = RemoveAwareMap<String, String>();
      final String key = 'testKey';
      final String value = 'testValue';
      map[key] = value;
      expect(map[key] == value, true);
      map.hasRemovedCallback = (dynamic key, dynamic value) {
        expect(key == 'testKey', true);
        expect(value == 'testValue', true);
      };
      map.remove(key);
      expect(map.isEmpty, true);

      map.hasRemovedCallback = null;
      map[key] = value;
      expect(map[key] == value, true);
      map.remove(key);
      expect(map.isEmpty, true);
    });
  });
}
