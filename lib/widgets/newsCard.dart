import 'package:flutter/material.dart';
import 'package:ibec_test/models/newsModel.dart';
import 'package:ibec_test/screens/singleNewsScreen.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({
    @required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleNewsScreen(
                    news: news,
                  )),
        );
      },
      child: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? 120
            : 130,
        padding: MediaQuery.of(context).orientation == Orientation.portrait
            ? EdgeInsets.symmetric(horizontal: 10, vertical: 6)
            : EdgeInsets.symmetric(horizontal: 50, vertical: 6),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          news.title.toString(),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // SizedBox(height: 10),
                      Flexible(
                        flex: 5,
                        child: Text(
                          news.description.toString(),
                          maxLines: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 2
                              : 3,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                news.urlToImage != null && news.urlToImage != 'null'
                    ? Flexible(
                        flex: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 3
                            : 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.network(
                            news.urlToImage.toString(),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
