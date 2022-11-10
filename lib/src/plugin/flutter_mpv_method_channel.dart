part of flutter_mpv;

/// An implementation of [FlutterMpvPlatform] that uses method channels.
class MethodChannelFlutterMpv extends FlutterMpvPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.xuelongqy.flutter.mpv');

  @override
  Future<MpvHolderEntity> create() async {
    final data = await methodChannel.invokeMethod<Map>('create');
    print(data);
    return MpvHolderEntity.fromJson(data);
  }

  @override
  Future dispose(int textureId) async {
    final data = await methodChannel.invokeMethod('dispose', textureId);
    return MpvHolderEntity.fromJson(data);
  }
}
