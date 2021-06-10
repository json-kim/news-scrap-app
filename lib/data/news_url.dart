enum Press {
  joongang,
  chosun,
  mk,
  hankook,
  hani,
}

Map<int, Press> numToPress = {
  0: Press.joongang,
  1: Press.chosun,
  2: Press.mk,
  3: Press.hankook,
  4: Press.hani,
};

const Map<Press, String> newsScrapUrl = {
  Press.chosun: '/main/list.nhn?mode=LPOD&mid=sec&oid=023',
  Press.hani: '/main/list.nhn?mode=LPOD&mid=sec&oid=028',
  Press.hankook: '/main/list.nhn?mode=LPOD&mid=sec&oid=469',
  Press.joongang: '/main/list.nhn?mode=LPOD&mid=sec&oid=025',
  Press.mk: '/main/list.nhn?mode=LPOD&mid=sec&oid=009',
};

const List<String> pressName = [
  '중앙일보',
  '조선일보',
  '매일경제',
  '한국일보',
  '한겨레',
];
