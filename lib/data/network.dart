import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ibec_test/models/NewsList.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

// String apiKey = '8f58d30c566946fbad9d1a3771246f1f';
String apiKey = '954446b3eba546549ce5db2de88d325c';
int count = 0;

class NewsProdRepository {
  Future<NewsList> fetchNews(int page, int pageSize) async {
    String fileName = "cachedNews.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    if (file.existsSync() && page == 1) {
      print("Loading from cache");

      var jsonData = file.readAsStringSync();
      return compute(parseNews, jsonData);
    } else {
      http.Response response = await http.get(
          "https://newsapi.org/v2/everything?q=bitcoin&pageSize=$pageSize&page=$page&apiKey=$apiKey");
      if (response.statusCode == 200) {
        //save json in local file
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return compute(parseNews, response.body);
      } else {
        throw Exception('fetch news ' + response.statusCode.toString());
      }
    }
  }
}

NewsList parseNews(String responseBody) {
  final Map newsMap = JsonCodec().decode(responseBody);
  NewsList news = NewsList.fromMap(newsMap);
  if (news == null) {
    throw new Exception("(CUSTOM) An error occurred : [ Status Code = ]");
  }
  return news;
}

// class AllNews {
//   Future getData() async {
//     http.Response response;
//     response = await http
//         .get("https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey");
//     if (response.statusCode == 200 ||
//         response.statusCode == 201 ||
//         response.statusCode == 202) {
//       String source = Utf8Decoder().convert(response.bodyBytes);
//       // print(jsonDecode(source));
//       return jsonDecode(source);
//     } else {
//       print('all news ' + response.statusCode.toString());
//     }
//   }
// }
//
// Future<List<News>> fetchNews(
//     BuildContext context, int pageSize, int page) async {
//   final response = await http.get(
//     "https://newsapi.org/v2/everything?q=bitcoin&pageSize=$pageSize&page=$page&apiKey=$apiKey",
//   );
//   count++;
//   // print(count);
//
//   if (response.statusCode == 200 ||
//       response.statusCode == 201 ||
//       response.statusCode == 202) {
//     String source = Utf8Decoder().convert(response.bodyBytes);
//     var jsonData = jsonDecode(source);
//     List newsList = jsonData['articles'];
//     List<News> news = [];
//     for (var single in newsList) {
//       News s = News(
//         srcId: single['source']['id'],
//         srcName: single['source']['name'],
//         author: single['author'],
//         title: single['title'],
//         description: single['description'],
//         url: single['url'],
//         urlToImage: single['urlToImage'],
//         publishedAt: single['publishedAt'],
//         content: single['content'],
//       );
//       news.add(s);
//     }
//     return news;
//   } else {
//     throw Exception('fetch news ' + response.statusCode.toString());
//   }
// }
