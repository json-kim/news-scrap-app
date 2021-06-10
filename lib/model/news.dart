import 'package:flutter/material.dart';
import '../data/news_url.dart';

//뉴스
class News {
  News({@required this.title, @required this.newsUrl, @required this.press});

  final String title;
  final String newsUrl;
  final Press press;
}

//포토뉴스 (사진만 있는 뉴스)
class PhotoNews extends News {
  PhotoNews(
      {@required String title,
      @required String newsUrl,
      @required Press press,
      @required this.imgUrl})
      : super(title: title, newsUrl: newsUrl, press: press);

  final String imgUrl;
}

//텍스트뉴스(텍스트만 있는 뉴스)
class TextNews extends News {
  TextNews(
      {@required String title,
      @required String newsUrl,
      @required Press press,
      @required this.text})
      : super(
          title: title,
          newsUrl: newsUrl,
          press: press,
        );

  final String text;

  factory TextNews.fromMap(Map<String, dynamic> map) {
    return TextNews(
        title: map['title'],
        newsUrl: map['href'],
        press: map['press'],
        text: map['text'] ?? '');
  }
}

//포토&텍스트튜스(사진&텍스트 둘 다 있는 뉴스)
class PhotoTextNews extends PhotoNews {
  PhotoTextNews({
    @required String title,
    @required String newsUrl,
    @required Press press,
    @required String imgUrl,
    this.text = '',
    this.subTitle = const {},
  }) : super(title: title, newsUrl: newsUrl, press: press, imgUrl: imgUrl);

  final String text;
  Map<String, String> subTitle;

  factory PhotoTextNews.fromMap(Map<String, dynamic> map) {
    return PhotoTextNews(
        title: map['title'] as String,
        newsUrl: map['href'] as String,
        press: map['press'] as Press,
        imgUrl: map['img'] as String,
        text: map['text'] ?? '',
        subTitle: map['subTitle'] ?? {});
  }
}
