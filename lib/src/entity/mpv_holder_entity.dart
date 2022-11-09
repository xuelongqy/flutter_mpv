part of flutter_mpv;

class MpvHolderEntity {
  MpvHolderEntity({
    required this.textureId,
    required this.wid,
  });

  MpvHolderEntity.fromJson(dynamic json) {
    textureId = (json['textureId'] as  num).toInt();
    wid = (json['wid'] as num).toInt();
  }

  late int textureId;
  late int wid;

  MpvHolderEntity copyWith({
    int? textureId,
    int? wid,
  }) =>
      MpvHolderEntity(
        textureId: textureId ?? this.textureId,
        wid: wid ?? this.wid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['textureId'] = textureId;
    map['wid'] = wid;
    return map;
  }
}
