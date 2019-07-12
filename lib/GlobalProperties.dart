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

  //干货集中营api
  static const GANKURL = "http://gank.io/api/data/%E7%A6%8F%E5%88%A9/";


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

  static const imgRule_230 ="?imageView2/3/h/230";//图片规则，从服务器取230大小的图片
  static const ImgRule_720 ="?imageMogr2/thumbnail/!1280x720r/gravity/Center/crop/1280x720";
  static const ImgRule_1080 ="?imageMogr2/thumbnail/!1920x1080r/gravity/Center/crop/1920x1080";

  static const ImgRule_vertical_720 ="?imageMogr2/thumbnail/!720x1280r/gravity/Center/crop/720x1280";
  static const ImgRule_vertical_1080 ="?imageMogr2/thumbnail/!1080x1920r/gravity/Center/crop/1080x1920";

  static const HERO_TAG_LOAD_IMAGE = "load_image";

}