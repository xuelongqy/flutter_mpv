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

  @override
  void initState() {
    super.initState();
    _create();
  }

  Future _create() async {
    _mpvHolder = await _flutterMpv.createSurface();
    final mpv = _mpvBinding.mpv_create();
    _mpvBinding.mpv_set_property_string(mpv, 'terminal'.toNativeUtf8().cast<Char>(), 'yes'.toNativeUtf8().cast<Char>());
    _mpvBinding.mpv_set_property_string(mpv, 'msg-level'.toNativeUtf8().cast<Char>(), 'all=v'.toNativeUtf8().cast<Char>());
    _mpvBinding.mpv_initialize(mpv);
    _mpvBinding.mpv_set_option(mpv, 'hwdec'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_NODE, _buildMpvNode('hwdec').cast<Void>());
    _mpvBinding.mpv_observe_property(mpv, 0, 'duration'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_DOUBLE);
    _mpvBinding.mpv_observe_property(mpv, 0, 'time-pos'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_DOUBLE);
    _mpvBinding.mpv_set_option(mpv, 'wid'.toNativeUtf8().cast<Char>(), mpv_format.MPV_FORMAT_INT64, Pointer.fromAddress(_mpvHolder!.wid));
    setState(() {});
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
