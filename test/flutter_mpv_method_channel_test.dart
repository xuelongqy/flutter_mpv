import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mpv/flutter_mpv.dart';

void main() {
  MethodChannelFlutterMpv platform = MethodChannelFlutterMpv();
  const MethodChannel channel = MethodChannel('com.xuelongqy.flutter.mpv');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return MpvHolderEntity.fromJson({
        'textureId': 0,
        'wid': 1,
      });
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('createSurface', () async {
    expect((await platform.createSurface()).textureId, 0);
  });
}
