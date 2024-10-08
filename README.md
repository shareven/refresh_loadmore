# refresh_loadmore

A Flutter component that supports pull-down refresh and pull-up to load more data (一个组件，支持下拉刷新，上拉加载更多数据).

## Getting Started

Add this line to pubspec.yaml ( 添加这一行到pubspec.yaml)

``` 
dependencies:
     refresh_loadmore: ^2.0.7
```

## How To Use

Use the class `RefreshLoadmore`

Properties and functions:
``` dart
  /// Callback function on pull down to refresh | 下拉刷新时的回调函数
  final Future<void> Function()? onRefresh;

  /// Callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function()? onLoadmore;

  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// Child widget | 子组件
  final Widget child;

  /// Prompt text widget when there is no more data at the bottom | 底部没有更多数据时的提示文字组件
  final Widget? noMoreWidget;

  /// Prompt widget when loading new data at the bottom | 正在加载数据时的提示组件
  final Widget? loadingWidget;

  /// Prompt padding for body if needed | 你可以自定义padding
  final EdgeInsetsGeometry? padding;

  /// You can use your custom scrollController, or not | 你可以使用自定义的 ScrollController，或者不使用
  final ScrollController? scrollController;

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
              noMoreWidget: Text(
                'No more data, you are at the end',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).disabledColor,
                ),
              ),
              isLastPage: isLastPage,
              child: list!.isNotEmpty
                  ? Column(
                      children: list!
                          .map(
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