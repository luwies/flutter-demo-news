import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  News(this.title, this.url);

  @JsonKey(name: 'news_id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
