import 'package:flutter/material.dart';
import 'package:new_paper_pj/services/global_method.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
      dateToShow,
      readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(dynamic json) {
    String title = json["title"] ?? "";
    String content = json["content"] ?? "";
    String description = json["description"] ?? "";
    String dateToShow ="";

    if(json["publishedAt"] != null){
      dateToShow =
          GlobalMethods.formattedDateText(json["publishedAt"]);
    }
    return NewsModel(
        newsId: json["source"]["id"] ?? "",
        sourceName: json["source"]["name"] ?? "",
        authorName: json["author"] ?? "",
        title: title,
        description: description,
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ??
            "https://www.msn.com/vi-vn/money/news/v%C3%AC-sao-ng%C3%A0y-c%C3%A0ng-nhi%E1%BB%81u-ng%C3%A2n-h%C3%A0ng-t%C4%83ng-l%C3%A3i-su%E1%BA%A5t-huy-%C4%91%E1%BB%99ng/ar-BB1pxxXl?ocid=msedgntp&pc=U531&cvid=c8b7d8a4e87b430c9afbb6f38238d70c&ei=32",
        publishedAt: json["publishedAt"] ?? "",
        content: content,
        dateToShow: dateToShow,
        readingTimeText: readingTime(title + description +content * 50).msg);
  }

  static List<NewsModel> newsFromsnapshot(List newSnapshot) {
    return newSnapshot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['newsId'] = newsId;
    data['sourceName'] = sourceName;
    data['authorName'] = authorName;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    data['dateToShow'] = dateToShow;
    data['readingTimeText'] = readingTimeText;
    return data;
  }
  @override
  String toString() {
    return 'NewsModel{newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content, dateToShow: $dateToShow, readingTimeText: $readingTimeText}';
  }
}
