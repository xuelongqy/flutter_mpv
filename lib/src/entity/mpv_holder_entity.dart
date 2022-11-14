part of flutter_mpv;

class MpvHolderEntity {
  MpvHolderEntity({
    required this.mpvHandle,
    required this.textureId,
    required this.wid,
  });

  MpvHolderEntity.fromJson(dynamic json) {
    mpvHandle = (json['mpvHandle'] as  num).toInt();
    textureId = (json['textureId'] as  num).toInt();
    wid = (json['wid'] as num).toInt();
  }

  late int mpvHandle;
  late int textureId;
  late int wid;

  MpvHolderEntity copyWith({
    int? mpvHandle,
    int? textureId,
    int? wid,
  }) =>
      MpvHolderEntity(
        mpvHandle: mpvHandle ?? this.mpvHandle,
        textureId: textureId ?? this.textureId,
        wid: wid ?? this.wid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mpvHandle'] = mpvHandle;
    map['textureId'] = textureId;
    map['wid'] = wid;
    return map;
  }
}
