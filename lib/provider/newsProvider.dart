import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../model/news.dart';
import '../data/news_url.dart';

class NewsProvider extends ChangeNotifier {
  static final NewsProvider instance = NewsProvider();
  List<News> _newsData = [];
  NewsProvider() {
    scrapNews([]);
  }

  List<News> get newsData => [..._newsData];

  Future scrapNews(List<Press> press) async {
    //기존 기사 제거
    _newsData.clear();

    press.forEach((press) async {
      final newsUrl = newsScrapUrl[press];

      //TODO: 네이버뉴스에서 기사 크롤링
      final webScraper = WebScraper('https://news.naver.com');
      if (await webScraper.loadWebPage(newsUrl)) {
        final elementAddress = 'div.list_body > ul > li > dl';
        final elements = webScraper.customGetElementNaver(elementAddress, []);

        elements.forEach((element) {
          element['press'] = Press.chosun;
          if (element['img'] == null) {
            //텍스트뉴스
            _newsData.add(TextNews.fromMap(element));
          } else {
            //포토뉴스
            _newsData.add(PhotoTextNews.fromMap(element));
          }
        });
      }
      notifyListeners();
    });
  }
}

class Test {
  //TODO: 중앙일보
  // var webScraper = WebScraper('https://joongang.joins.com');
  // if (await webScraper.loadWebPage('/?cloc=joongang-home-bi')) {
  //   final elements =
  //       webScraper.customGetElement('div.type1 > ul.list_vertical > li', []);

  //   elements.forEach((element) {
  //     element['press'] = Press.joongang;
  //     _newsData.add(PhotoTextNews.fromMap(element));
  //   });
  // }
}
