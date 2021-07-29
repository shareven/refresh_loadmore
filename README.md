# refresh_loadmore

A Flutter component that supports pull-down refresh and pull-up to load more data (一个组件，支持下拉刷新，上拉加载更多数据).

## Getting Started

Add this line to pubspec.yaml ( 添加这一行到pubspec.yaml)

``` 
dependencies:
     refresh_loadmore: ^2.0.3
```

## How To Use

Use the class `RefreshLoadmore`

Properties and functions:
``` dart
  /// callback function on pull down to refresh | 下拉刷新时的回调函数
  final Future<void> Function()? onRefresh;

  /// callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function()? onLoadmore;

  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// child widget | 子组件
  final Widget child;

  /// Prompt text when there is no more data at the bottom | 底部没有更多数据时的提示文字
  final String? noMoreText;

  /// [noMoreText] text style | [noMoreText]的文字样式
  final TextStyle? noMoreTextStyle;
```

## Examples

```dart
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  /// is the last page | 是否为最后一页
  bool isLastPage = false;

  List? list;
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
                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    list!.addAll(['123', '234', '457']);
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
              child: list!.isNotEmpty
                  ? Column(
                      children: list
                          !.map(
                            (e) => ListTile(
                              title: Text(e),
                              trailing: Icon(Icons.accessibility_new),
                            ),
                          )
                          .toList(),
                    )
                  : Center(
                      child: Text('empty'),
                    ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}


```

## Renderings
![images](https://pic2.zhimg.com/80/v2-aa952f4100a918accbbe5a48275ef256_720w.jpeg)
![images](https://pic3.zhimg.com/80/v2-c938552cdc075ac9f8fde56611db7371_720w.jpeg)
![images](https://pic1.zhimg.com/80/v2-32c016eac49e83bce68a227a80f5d8ec_720w.jpeg)