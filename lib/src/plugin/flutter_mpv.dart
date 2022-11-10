part of flutter_mpv;

class FlutterMpv {
  Future<MpvHolderEntity> create() {
    return FlutterMpvPlatform.instance.create();
  }

  Future dispose(int textureId) {
    return FlutterMpvPlatform.instance.dispose(textureId);
  }
}
