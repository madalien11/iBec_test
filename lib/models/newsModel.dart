class News {
  final String srcId;
  final String srcName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  News({
    this.srcId,
    this.srcName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory News.fromJson(Map value) {
    return News(
      title: value['title'].toString(),
      srcId: value['source']['id'].toString(),
      srcName: value['source']['name'].toString(),
      author: value['author'].toString(),
      description: value['description'].toString(),
      url: value['url'].toString(),
      urlToImage: value['urlToImage'].toString(),
      publishedAt: value['publishedAt'].toString(),
      content: value['content'].toString(),
    );
  }
}
