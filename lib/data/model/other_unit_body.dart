class OtherUnitBody {
  OtherUnitBody({
    int? unitId,
  }) {
    _unitId = unitId;
  }

  OtherUnitBody.fromJson(dynamic json) {
    _unitId = json['unit_id'];
  }

  int? _unitId;

  int? get unitId => _unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit_id'] = _unitId;
    return map;
  }
}