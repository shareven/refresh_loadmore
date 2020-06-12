import 'package:flutter/material.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLastPage = false; /// is the last page | 是否为最后一页
  List list;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadFirstData();
  }

  Future<void> loadFirstData() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        list = [
          'dddd',
          'sdfasfa',
          'sdfgaf',
          'adsgafg',
          'dddd',
          'sdfasfa',
          'sdfgaf',
          'adsgafg',
          'dddd',
          'sdfasfa',
          'sdfgaf',
          'adsgafg'
          'adsgafg',
          'dddd',
          'sdfasfa',
          'sdfgaf',
          'adsgafg'
        ];
        isLastPage = false;
        page = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: list != null
          ? RefreshLoadmore(
              onRefresh: loadFirstData,
              onLoadmore: () async {
                if (isLastPage) return;

                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    list.addAll(['123', '234', '457']);
                    page++;
                  });
                  print(page);
                  if (page >= 3) {
                    setState(() {
                      isLastPage = true;
                    });
                  }
                });
              },
              noMoreText: 'No more data, you are at the end',
              isLastPage: isLastPage,
              children: list
                  .map(
                    (e) => ListTile(
                      title: Text(e),
                      trailing: Icon(Icons.accessibility_new),
                    ),
                  )
                  .toList(),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
