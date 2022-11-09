part of flutter_mpv;

abstract class FlutterMpvPlatform extends PlatformInterface {
  /// Constructs a FlutterMpvPlatform.
  FlutterMpvPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMpvPlatform _instance = MethodChannelFlutterMpv();

  /// The default instance of [FlutterMpvPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMpv].
  static FlutterMpvPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMpvPlatform] when
  /// they register themselves.
  static set instance(FlutterMpvPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<MpvHolderEntity> createSurface() {
    throw UnimplementedError('createSurface() has not been implemented.');
  }
}
