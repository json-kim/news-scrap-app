import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    if (news is TextNews) {
      final tNews = news as TextNews;
      return InkWell(
        onTap: () {
          //TODO: 뉴스 웹사이트로 이동
          _launchURL(news.newsUrl);
        },
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width / 10 * 4,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all()),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: EdgeInsets.symmetric(vertical: 4),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                tNews.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          if (tNews.text != '')
                            Text(tNews.text,
                                style: TextStyle(fontSize: 18),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      );
    } else {
      final ptNews = news as PhotoTextNews;
      return InkWell(
        onTap: () {
          //TODO: 뉴스 웹사이트로 이동
          _launchURL(news.newsUrl);
        },
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width / 10 * 4,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all()),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: EdgeInsets.symmetric(vertical: 4),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                news.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ptNews.imgUrl == null
                      ? Container()
                      : Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.center,
                            child: ptNews.imgUrl == null
                                ? Icon(Icons.no_food_outlined)
                                : Image.network(
                                    ptNews.imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          if (ptNews.text != '')
                            Text(ptNews.text,
                                style: TextStyle(fontSize: 18),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                          if (ptNews.subTitle.isNotEmpty)
                            ...ptNews.subTitle.keys
                                .map((key) => Text(
                                      ptNews.subTitle[key],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ))
                                .toList()
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  void _launchURL(String url) async {
    try {
      await canLaunch(url)
          ? await launch(
              url,
              //인앱 브라우저 호출 여부
              //위에서부터 순서로 ios, 안드로이드
              forceSafariVC: false,
              forceWebView: false,
            )
          : throw 'Could not launch $url';
    } catch (e) {
      print(e);
    }
  }
}
