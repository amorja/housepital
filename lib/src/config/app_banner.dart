import 'package:flutter/material.dart';
import 'package:housepital/src/config/app_config.dart';
import 'package:housepital/src/config/app_deviceInfo.dart';

class AppFlavorBanner extends StatelessWidget {
  final Widget child;
  BannerConfig bannerConfig;

  AppFlavorBanner({@required this.child});

  @override
  Widget build(BuildContext context) {
    if (AppFlavorConfig.isProduction()) return child;

    bannerConfig??= _getDefaultBanner();

    return Stack(
      children: <Widget>[
        child,
        _buildBanner(context),
      ],
    );
  }

  BannerConfig _getDefaultBanner() {
    return BannerConfig(
      bannerName: AppFlavorConfig.instance.name,
      bannerColor: AppFlavorConfig.instance.color,
    );
  }

  Widget _buildBanner(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CustomPaint(
          painter: BannerPainter(
            message: bannerConfig.bannerName,
            color: bannerConfig.bannerColor,
            location: BannerLocation.topStart,
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context)
          ),
        ),
      ),
      onLongPress: () {
        // this function work only in physical device 
        // to show the device info;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeviceInfoDialog();
          }
        );
      },
    );
  }
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;

  BannerConfig({
    @required this.bannerName,
    @required this.bannerColor,
  });
}