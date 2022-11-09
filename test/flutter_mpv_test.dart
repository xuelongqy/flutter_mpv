import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mpv/flutter_mpv.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMpvPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMpvPlatform {

  @override
  Future<MpvHolderEntity> createSurface() => Future.value(MpvHolderEntity.fromJson({
    'textureId': 0,
    'wid': 1,
  }));
}

void main() {
  final FlutterMpvPlatform initialPlatform = FlutterMpvPlatform.instance;

  test('$MethodChannelFlutterMpv is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMpv>());
  });

  test('getPlatformVersion', () async {
    FlutterMpv flutterMpvPlugin = FlutterMpv();
    MockFlutterMpvPlatform fakePlatform = MockFlutterMpvPlatform();
    FlutterMpvPlatform.instance = fakePlatform;

    expect((await flutterMpvPlugin.createSurface()).textureId, 0);
  });
}
