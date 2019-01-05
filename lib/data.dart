import 'package:json_annotation/json_annotation.dart';

import 'news.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'news')
  List<News> data;

  Data(this.data);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
