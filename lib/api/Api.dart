class Api {
  static final String HOST = "http://news-at.zhihu.com/api/4/";

  // 今日热闻
  static final String getLatest = HOST +"news/latest";
  // 新闻详情
  static final String getDetailContent = HOST +"story/";
  //获取某个主题日报的列表
  static final String getTheme = HOST +"theme/";
  //获取theme列表
  static final String themes = HOST +"themes";



}