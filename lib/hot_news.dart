import 'package:flutter/material.dart';
import 'news.dart';
import 'package:http/http.dart' as http;
import 'result.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HotNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<HotNews>  with AutomaticKeepAliveClientMixin  {
  final List<News> newsData = <News>[];
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  Future<void> fetchPost() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final response = await http
        .get('https://api.xinwen.cn/news/hot?size=150${getPubicParams()}');
    isLoading = false;
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final result = Result.fromJson(json.decode(response.body));
      if (result.sucess) {
        setState(() {
          newsData.clear();
          newsData.addAll(result.data.data);
        });
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  String getPubicParams() {
    final time = new DateTime.now().millisecondsSinceEpoch;
    final accessKey = '2DytdHnEbxXDixQh';
    final secretKeyValue = '9ac988e1e26e41679285a49aa387cd5c';
    final sign = generateMd5("$secretKeyValue$time$accessKey");
    return '&signature=$sign&timestamp=$time&access_key=$accessKey';
  }

// md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
          child: createBody(),
          onRefresh: fetchPost,
        ),
      );
  }

  Widget createBody() {
    if (newsData.length <= 0) {
      return CircularProgressIndicator();
    }
    return getListView(newsData);
  }

  Widget getListView(List<News> data) {
    return ListView.builder(
      itemCount: newsData.length ,
      itemBuilder: (context, index) {
        if (index < newsData.length) {
          News item = data[index];
          return ListTile(
              title: Text(item.title),
              onTap: () {
                goDetail(item.url);
              });
        } else {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Opacity(
                opacity: isLoading ? 1.0 : 0.0,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  void goDetail(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WebviewScaffold(
                url: url,
                appBar: new AppBar(
                  title: new Text("新闻详情"),
                ),
              )),
    );
  }
}
