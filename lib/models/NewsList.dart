import 'package:ibec_test/models/newsModel.dart';

class NewsList {
  NewsList({
    this.news,
  });

  List<News> news;

  NewsList.fromMap(Map<String, dynamic> value)
      : news = new List<News>.from(
            value['articles'].map((aNews) => News.fromJson(aNews)));
}
