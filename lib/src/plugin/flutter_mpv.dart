part of flutter_mpv;

class FlutterMpv {
  Future<MpvHolderEntity> createSurface() {
    return FlutterMpvPlatform.instance.createSurface();
  }
}
