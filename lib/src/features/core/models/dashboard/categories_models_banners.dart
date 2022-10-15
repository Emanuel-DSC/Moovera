import 'package:flutter/animation.dart';
import 'package:movie_login/src/constants/text_string.dart';

class DashBoardBanners {
  final String bannerNumber;
  final String bannerTitle;
  final VoidCallback? onPress;

  DashBoardBanners(this.bannerNumber, this.bannerTitle, this.onPress);

  static List<DashBoardBanners> list = [
    DashBoardBanners(tBanner1, tBannerText1, null),
    DashBoardBanners(tBanner2, tBannerText2, null),
    DashBoardBanners(tBanner3, tBannerText3, null),

  ];
}
