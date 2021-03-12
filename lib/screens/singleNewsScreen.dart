import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibec_test/models/newsModel.dart';
import 'dart:io';

class SingleNewsScreen extends StatelessWidget {
  final News news;

  SingleNewsScreen({@required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text("News"),
              trailing: GestureDetector(
                child: Icon(CupertinoIcons.ellipsis_vertical),
                onTap: () {},
              ),
              leading: GestureDetector(
                child: Icon(CupertinoIcons.back),
                onTap: () {},
              ),
            )
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text("News"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_rounded),
                )
              ],
            ),
      body: Padding(
        padding: MediaQuery.of(context).orientation == Orientation.portrait
            ? const EdgeInsets.all(10.0)
            : const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: ListView(
          children: [
            news.urlToImage != null && news.urlToImage != 'null'
                ? Image.network(
                    news.urlToImage.toString(),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  )
                : Container(),
            SizedBox(height: 16),
            if (news.title != null && news.title != 'null')
              Text(
                news.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            SizedBox(height: 10),
            if (news.description != null && news.description != 'null')
              Text(news.description),
            SizedBox(height: 10),
            if (news.content != null && news.content != 'null')
              Text(news.content),
            SizedBox(height: 50),
            if (news.url != null && news.url != 'null') Text(news.url),
            SizedBox(height: 4),
            Text('Source name: ' + news.srcName.toString()),
            SizedBox(height: 4),
            Text('Source id: ' + news.srcId.toString()),
            SizedBox(height: 4),
            if (news.publishedAt != null && news.publishedAt != 'null')
              Text(news.publishedAt),
            SizedBox(height: 4),
            Text('Author: ' + news.author.toString()),
          ],
        ),
      ),
    );
  }
}
