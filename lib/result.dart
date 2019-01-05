import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: 'success')
  bool sucess;

  @JsonKey(name: 'data')
  Data data;

  Result(this.sucess, this.data);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
