class GlobalProperties{
  static const BASE_URL = "http://service.picasso.adesk.com";
  /**
   * 每次请求多少个数据
   */
  static const int limit = 30;
  /**
   * 主页面
   */
  static const HOMEPAGE_URL = "/v3/homepage";
  /**
   * 竖屏 最热
   */
  static const VERTICAL_URLS = "/v1/vertical/vertical" +
      "?limit=30?adult=false&first=1&order=hot";

  /**
   * banner
   */
  static const BANNER_URL = "/v1/wallpaper/";

  /**
   * 竖屏
   */
  static const VERTICAL_URL = "/v1/vertical/vertical";

  /**
   * 专辑
   */
  static const SPECIAL_URL = "/v1/wallpaper/album";
  /**
   * 分类
   */
  static const CATEGORY_URL = "/v1/wallpaper/category";
  /**
   * 竖屏分类
   */
  static const CATEGORY_VERTICAL_URL = "/v1/vertical/category";

  /**
   * 评论
   */
  static const COMMENT_URL = "/v2/wallpaper/wallpaper";

  //安卓壁纸的搜索
  static const SEARCH_URL = "http://so.picasso.adesk.com";
  //关键词
  static const SEARCH_KEY_URL = "/v1/push/keyword?versionCode=181&channel=huawei&first=0&adult=false";

  //百度识图
  static const BAIDU_URL = "http://image.baidu.com/wiseshitu?guss=1&queryImageUrl=";
  //搜狗识图
  static const SOUGOU_URL = "http://pic.sogou.com/";
  //google识图
  static const GOOGLE_URL = "https://images.google.com/imghp?hl=zh-CN&gws_rd=ssl";

}