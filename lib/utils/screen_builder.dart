import 'package:flutter_web/material.dart';

import 'package:fw_resume/page/mobile.dart';
import 'package:fw_resume/page/desktop.dart';


class ScreenBuilder extends StatelessWidget {
  static const double SMALL_WIDTH = 768.0;
  static const double HUGE_WIDTH = 1024.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // print('PixelRatio: ${mediaQuery.devicePixelRatio}');
    final baseSize = (mediaQuery.size.width > HUGE_WIDTH)
        ? HUGE_WIDTH
        : mediaQuery.size.width;
    final minSize = (mediaQuery.size.width > mediaQuery.size.height)
        ? mediaQuery.size.height
        : mediaQuery.size.width;
    final scale = baseSize / HUGE_WIDTH;
    final fontScale = (baseSize <= SMALL_WIDTH) ? 1.5 : 1.2;
    final orientation = mediaQuery.orientation;
    // html.window.console.log(mediaQuery);

    return ScreenParams(
      baseSize: baseSize,
      scale: scale,
      fontScale: fontScale,
      child: (mediaQuery.size.width > HUGE_WIDTH && minSize >= 600.0)
          ? _buildDesk(padding: (mediaQuery.size.width - HUGE_WIDTH) / 2)
          : (minSize >= 768.0)
              ? _buildTablet()
              : (orientation == Orientation.portrait)
                  ? _buildPhonePort()
                  : _buildPhoneLand(),
    );
  }

  Widget _buildPhonePort() {
    return MobilePage();
  }

  Widget _buildPhoneLand() {
    return MobilePage();
  }

  Widget _buildTablet() {
    return MobilePage();
  }

  Widget _buildDesk({double padding}) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            'image/code_back.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: DesktopPage()),
      ],
    );
  }
}

class ScreenParams extends InheritedModel {
  final double baseSize;
  final double scale;
  final double fontScale;

  ScreenParams(
      {@required this.baseSize,
      @required this.scale,
      @required this.fontScale,
      @required Widget child})
      : super(child: child);

  static ScreenParams of(BuildContext context) {
    return InheritedModel.inheritFrom<ScreenParams>(context);
  }

  @override
  bool updateShouldNotify(ScreenParams old) {
    if (baseSize == old.baseSize &&
        scale == old.scale &&
        fontScale == old.fontScale) return false;
    return true;
  }

  @override
  bool updateShouldNotifyDependent(ScreenParams oldWidget, Set dependencies) {
    return false;
  }
}
