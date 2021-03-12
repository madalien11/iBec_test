import 'package:flutter/material.dart';
import 'package:ibec_test/data/network.dart';
import 'package:ibec_test/models/NewsList.dart';
import 'package:ibec_test/models/newsModel.dart';
import 'package:ibec_test/widgets/newsTile.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

int pageSize = 10;
int myPage = 1;
// List<News> lst = [];
// bool pageCalled = false;
// bool firstCalled = false;
// int counter = 0;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<News>> futureListOfNews;

  // Future<List<News>> _loadData() async {
  //   if (!firstCalled) {
  //     firstCalled = true;
  //     // update data and loading status
  //     await fetchNews(context, pageSize, myPage)
  //         .then((value) => value.forEach((element) {
  //               lst.add(element);
  //             }));
  //
  //     // perform fetching data delay
  //     // await new Future.delayed(new Duration(seconds: 2));
  //
  //     setState(() {
  //       pageCalled = false;
  //     });
  //
  //     counter++;
  //     print(counter);
  //   }
  //   return lst;
  // }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("News"),
            trailing: GestureDetector(
              child: Icon(CupertinoIcons.ellipsis_vertical),
              onTap: () {},
            ),
            leading: GestureDetector(
              child: Icon(CupertinoIcons.bars),
              onTap: () {},
            ),
          )
        : AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
            title: Text("News"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_rounded),
              )
            ],
          );

    final pageBody = FutureBuilder<NewsList>(
      future: NewsProdRepository().fetchNews(myPage, pageSize),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomRefresher(
            text: "Error Occurred",
            onRefresh: () async {
              myPage = 1;
              await NewsProdRepository().fetchNews(myPage, pageSize);
              setState(() {});
            },
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Platform.isIOS
                ? Center(child: CupertinoActivityIndicator())
                : Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            return NewsTile(news: snapshot.data);

          default:
            return CustomRefresher(
              text: "Something went wrong",
              onRefresh: () async {
                myPage = 1;
                await NewsProdRepository().fetchNews(myPage, pageSize);
                setState(() {});
              },
            );
        }
        // if (snapshot.hasData) {
        //   return NotificationListener<ScrollNotification>(
        //     // ignore: missing_return
        //     onNotification: (ScrollNotification scrollInfo) {
        //       if (scrollInfo.metrics.pixels ==
        //           scrollInfo.metrics.maxScrollExtent) {
        //         if (!pageCalled) {
        //           _loadData();
        //           pageCalled = true;
        //         }
        //       }
        //     },
        //     child: ListView.builder(
        //       itemCount: lst.length,
        //       itemBuilder: (context, index) {
        //         return NewsCard(
        //           news: lst[index],
        //         );
        //       },
        //     ),
        //   );
        // } else if (snapshot.hasError) {
        //   return Text("${snapshot.error}");
        // }
        //
        // // By default, show a loading spinner.
        // return Center(
        //     child: CircularProgressIndicator(
        //         backgroundColor: Color(0xffFF7A00)));
      },
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
          );
  }
}

class CustomRefresher extends StatelessWidget {
  const CustomRefresher({@required this.text, @required this.onRefresh});
  final String text;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          // color: Colors.white,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
