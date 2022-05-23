// import 'package:flutter/src/painting/image_provider.dart';
// import 'package:flutter/src/painting/image_stream.dart';
import 'dart:typed_data';
import 'dart:ui' as ui show Codec;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_image_ext/image_cache_ext.dart';
import 'package:power_image_ext/image_provider_ext.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('ImageCacheExt', () {
    setUp(() {});

    test('dispose', () {
      ImageCacheExt imageCacheExt = ImageCacheExt();
      TestImageProviderExt testImageProviderExt = TestImageProviderExt(Uint8List.fromList(
          List<int>.filled( 4, 0, growable: false)));
      final ImageStreamCompleter? completer = imageCacheExt.putIfAbsent(testImageProviderExt, ()  {
        return testImageProviderExt.load(testImageProviderExt, PaintingBinding.instance!.instantiateImageCodec);
      });
      expect(testImageProviderExt.disposed == false, true);
      imageCacheExt.evict(testImageProviderExt);
      Future.microtask(() {
        expect(testImageProviderExt.disposed == true, true);
      });
    });
  });
}


class TestImageProviderExt extends ImageProviderExt<TestImageProviderExt>{

  TestImageProviderExt(this.bytes, { this.scale = 1.0 })
      : assert(bytes != null),
        assert(scale != null);

  bool disposed = false;

  final Uint8List bytes;

  final double scale;

  @override
  Future<TestImageProviderExt> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TestImageProviderExt>(this);
  }

  @override
  ImageStreamCompleter load(TestImageProviderExt key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
      debugLabel: 'TestImageProviderExt(${describeIdentity(key.bytes)})',
    );
  }

  Future<ui.Codec> _loadAsync(TestImageProviderExt key, DecoderCallback decode) {
    assert(key == this);

    return decode(bytes);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    return other is TestImageProviderExt
        && other.bytes == bytes
        && other.scale == scale;
  }

  @override
  int get hashCode => hashValues(bytes.hashCode, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'TestImageProviderExt')}(${describeIdentity(bytes)}, scale: $scale)';

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}