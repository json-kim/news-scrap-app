import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../model/news.dart';
import '../data/news_url.dart';
import '../provider/newsProvider.dart';
import '../widget/news_card.dart';

class SliverFixedHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  SliverFixedHeader(
      {@required this.maxHeight,
      @required this.minHeight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverFixedHeader oldDelegate) {
    return oldDelegate.maxHeight != this.maxHeight ||
        oldDelegate.minHeight != this.minHeight ||
        oldDelegate.child != this.child;
  }
}

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<int> selectedNum = Set<int>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
        body: Center(
          child: CustomScrollView(
            slivers: [
              _renderNewsAppBar(),
              _renderPressHeader(),
              CupertinoSliverRefreshControl(
                refreshIndicatorExtent: 100,
                refreshTriggerPullDistance: 150,
                onRefresh: () async {
                  final selectedNumList = selectedNum.toList();
                  await Provider.of<NewsProvider>(context, listen: false)
                      .scrapNews(List.generate(selectedNumList.length,
                          (index) => numToPress[selectedNumList[index]]));
                },
              ),
              _renderSliverNewsList(),
            ],
          ),
        ),
      ),
    );
  }

  _renderNewsAppBar() {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      title: Text('마이뉴스'),
      elevation: 20,
      floating: true,
    );
  }

  _renderPressHeader() {
    return SliverPersistentHeader(
        delegate: SliverFixedHeader(
            maxHeight: 100,
            minHeight: 0,
            child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GroupButton(
                        selectedButtons: selectedNum.toList(),
                        isRadio: false,
                        borderRadius: BorderRadius.circular(20),
                        spacing: 5,
                        buttons: pressName.map((n) => n).toList(),
                        onSelected: (index, isSelected) {
                          setState(() {
                            selectedNum.add(index);
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('언론사 선택 후 아래 방향으로 스크롤...'),
                    ],
                  ),
                ))));
  }

  _renderSliverNewsList() {
    final news = Provider.of<NewsProvider>(context).newsData;
    if (news.length == 0) {
      return SliverList(
          delegate: SliverChildListDelegate([
        SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              200,
          child: Center(
            child: Text('언론사를 선택해주세요'),
          ),
        )
      ]));
    }
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: NewsCard(news[index]),
      );
    }, childCount: news.length));
  }
}
