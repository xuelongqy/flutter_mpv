part of flutter_mpv;

class MpvPlayer extends StatefulWidget {
  const MpvPlayer({Key? key}) : super(key: key);

  @override
  State<MpvPlayer> createState() => _MpvPlayerState();
}

class _MpvPlayerState extends State<MpvPlayer> {
  final _flutterMpv = FlutterMpv();
  final _mpvBinding = MpvBinding.i;
  MpvHolderEntity? _mpvHolder;
  late Pointer<mpv_handle> _mpv;

  @override
  void initState() {
    super.initState();
    _create();
  }

  @override
  void dispose() {
    super.dispose();
    if (_mpvHolder != null) {
      _flutterMpv.dispose(_mpvHolder!);
    }
    _mpvBinding.mpv_terminate_destroy(_mpv);
  }

  Future _create() async {
    _mpv = _mpvBinding.mpv_create();
    _mpvHolder = await _flutterMpv.create(_mpv.address);
    _setOptionString("vo", "mediacodec_embed");
    // _setOptionString("vo", "gpu");
    _setOptionString("gpu-context", "android");
    _setOptionString('hwdec', 'mediacodec');
    // _mpvBinding.mpv_set_option(_mpv, 'hwdec'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_NODE, _buildMpvNode('hwdec').cast<Void>());
    _setOptionString("hwdec-codecs", "h264,hevc,mpeg4,mpeg2video,vp8,vp9");
    _setOptionString("ao", "audiotrack,opensles");
    // _setOptionString("tls-verify", "yes");
    _setOptionString("input-default-bindings", "yes");
    _setOptionString("demuxer-max-bytes", "${64 * 1024 * 1024}");
    _setOptionString("demuxer-max-back-bytes", "${64 * 1024 * 1024}");
    _setOptionString("vd-lavc-dr", "no");
    _mpvBinding.mpv_initialize(_mpv);
    // _mpvBinding.mpv_observe_property(_mpv, 0, 'duration'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_DOUBLE);
    // _mpvBinding.mpv_observe_property(_mpv, 0, 'time-pos'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_DOUBLE);
    final widPointer = malloc.call<Int64>(1)..value = _mpvHolder!.wid;
    _mpvBinding.mpv_set_option(_mpv, 'wid'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_INT64, widPointer.cast<Void>());
    malloc.free(widPointer);
    _setOptionString("force-window", "yes");
    final args = malloc.call<Pointer<Char>>(3);
    args[0] = 'loadfile'.toNativeUtf8().cast<Char>();
    args[1] = 'https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_10mb.mkv'.toNativeUtf8().cast<Char>();
    args[2] = nullptr;
    _mpvBinding.mpv_command_async(_mpv, 0, args);
    setState(() {});
  }

  void _setOptionString(String key, String value) {
    _mpvBinding.mpv_set_property_string(_mpv, key.toNativeUtf8().cast<Char>(), value.toNativeUtf8().cast<Char>());
  }

  Pointer<mpv_node> _buildMpvNode(String dst) {
    final node = malloc.call<mpv_node>(1)..ref.format = mpv_format.MPV_FORMAT_STRING
      ..ref.u.string = 'yes'.toNativeUtf8().cast<Char>();
    return node;
  }

  @override
  Widget build(BuildContext context) {
    return _mpvHolder == null
        ? const SizedBox()
        : Texture(textureId: _mpvHolder!.textureId);
  }
}
