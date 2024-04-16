class KeepaUrlHelper {
  static const W = '400';
  static const H = '180';
  static String getGraphImageUrl({required String asin}) {
    final url =
        "https://graph.keepa.com/pricehistory.png?used=1&amazon=1&new=1&domain=co.jp&width=$W&asin=" +
            asin +
            "&salesrank=1&height=$H";
    return url;
  }

  static String getGraphImageUrlWithApiKey(
      {required String asin, required String apiKey}) {
    final url =
        "https://api.keepa.com/graphimage?key=$apiKey&domain=5&asin=$asin&salesrank=1&bb=1&used=1&&wd=1";
    return url;
  }
}
