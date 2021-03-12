import 'package:flutter/material.dart';
import 'package:ibec_test/data/network.dart';
import 'package:ibec_test/models/NewsList.dart';
import 'package:ibec_test/models/newsModel.dart';
import 'package:async/async.dart';
import 'package:ibec_test/widgets/newsCard.dart';
import 'package:ibec_test/screens/mainScreen.dart';

enum NewsLoadMoreStatus { LOADING, STABLE }

class NewsTile extends StatefulWidget {
  final NewsList news;

  NewsTile({this.news});

  @override
  State<StatefulWidget> createState() => NewsTileState();
}

class NewsTileState extends State<NewsTile> {
  NewsLoadMoreStatus loadMoreStatus = NewsLoadMoreStatus.STABLE;
  final ScrollController scrollController = ScrollController();
  List<News> news;
  CancelableOperation newsOperation;

  @override
  void initState() {
    news = widget.news.news;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (newsOperation != null) newsOperation.cancel();
    super.dispose();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == NewsLoadMoreStatus.STABLE) {
          loadMoreStatus = NewsLoadMoreStatus.LOADING;
          newsOperation = CancelableOperation.fromFuture(NewsProdRepository()
              .fetchNews(myPage + 1, pageSize)
              .then((newsObject) {
            myPage++;
            loadMoreStatus = NewsLoadMoreStatus.STABLE;
            setState(() => news.addAll(newsObject.news));
          }));
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: RefreshIndicator(
        onRefresh: () async {
          myPage = 1;
          await NewsProdRepository().fetchNews(myPage, pageSize).then((value) {
            news.clear();
            setState(() => news.addAll(value.news));
          });
        },
        child: ListView.builder(
          controller: scrollController,
          itemCount: news.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return NewsCard(news: news[index]);
          },
        ),
      ),
    );
  }
}
