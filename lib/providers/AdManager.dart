import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get appId => 'ca-app-pub-3940256099942544~3347511713';
  static String get bannerAdUnitId => 'ca-app-pub-3940256099942544/6300978111';

  static Future<InitializationStatus> initialize() async {
    return await MobileAds.instance.initialize();
  }

  static BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
  }

  static Future<AdWidget> createAdWidget() async {
    BannerAd banner = AdManager._createBannerAd();
    await banner.load();
    return AdWidget(ad: banner);
  }
}
