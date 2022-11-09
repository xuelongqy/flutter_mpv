part of flutter_mpv;

/// An implementation of [FlutterMpvPlatform] that uses method channels.
class MethodChannelFlutterMpv extends FlutterMpvPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.xuelongqy.flutter.mpv');

  @override
  Future<MpvHolderEntity> createSurface() async {
    final data = await methodChannel.invokeMethod<Map>('createSurface');
    print(data);
    return MpvHolderEntity.fromJson(data);
  }
}
