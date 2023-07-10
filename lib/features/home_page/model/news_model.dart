class NewsModel {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final NewsSourceModel? source;

  NewsModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.source
      });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        author: json['author'],
        title: json["title"],
        content: json["content"],
        description: json["description"],
        publishedAt: json["publishedAt"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        source: NewsSourceModel.fromJson(json["source"])
    );
  }
}


class NewsSourceModel {
  final String? id;
  final String? name;

  NewsSourceModel({this.id, this.name});

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) {
    return NewsSourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

