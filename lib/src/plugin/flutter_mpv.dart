part of flutter_mpv;

class FlutterMpv {
  Future<MpvHolderEntity> create(int mpvHandle) {
    return FlutterMpvPlatform.instance.create(mpvHandle);
  }

  Future dispose(MpvHolderEntity mpvHolder) {
    return FlutterMpvPlatform.instance.dispose(mpvHolder);
  }
}
