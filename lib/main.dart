import 'package:flutter/material.dart';
import 'real_news.dart';
import 'selection_news.dart';
import 'hot_news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final body = <Widget>[RealNews(), SelectionNews(), HotNews()];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: '实时',
                ),
                Tab(
                  text: '精选',
                ),
                Tab(
                  text: '热门',
                ),
              ],
            ),
            title: Text('简单新闻'),
          ),
          body: TabBarView(
            children: body,
          ),
        ),
      ),
    );
  }
}
