// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(json['title'] as String, json['url'] as String)
    ..id = json['news_id'] as String;
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'news_id': instance.id,
      'title': instance.title,
      'url': instance.url
    };
