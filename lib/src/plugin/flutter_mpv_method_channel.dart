part of flutter_mpv;

/// An implementation of [FlutterMpvPlatform] that uses method channels.
class MethodChannelFlutterMpv extends FlutterMpvPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.xuelongqy.flutter.mpv');

  @override
  Future<MpvHolderEntity> create(int mpvHandle) async {
    final data = await methodChannel.invokeMethod<Map>('create', mpvHandle);
    return MpvHolderEntity.fromJson(data);
  }

  @override
  Future dispose(MpvHolderEntity mpvHolder) async {
    final data = await methodChannel.invokeMethod('dispose', mpvHolder.toJson());
    return MpvHolderEntity.fromJson(data);
  }
}
