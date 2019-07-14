import 'package:flutter_web/material.dart';

class Icons {
  Icons._();

  static const IconData tooltip = IconData(0xf293, fontFamily: 'fa');
  static const IconData menu = IconData(0xf0c9, fontFamily: 'fa');
  static const IconData globe = IconData(0xf0ac, fontFamily: 'fa');
  static const IconData book = IconData(0xf02d, fontFamily: 'fa');
  static const IconData brief = IconData(0xf0b1, fontFamily: 'fa');
  static const IconData achive = IconData(0xf091, fontFamily: 'fa');
  static const IconData email = IconData(0xf0e0, fontFamily: 'fa');
  static const IconData telegram = IconData(0xf2c6, fontFamily: 'fa');
  static const IconData bolt = IconData(0xf0e7, fontFamily: 'fa');
  static const IconData gitFork = IconData(0xf09b, fontFamily: 'fa');
  static const IconData fileCode = IconData(0xf1c9, fontFamily: 'fa');
  static const IconData handShake = IconData(0xf2b5, fontFamily: 'fa');
  static const IconData handRight = IconData(0xf0a4, fontFamily: 'fa');
  static const IconData money = IconData(0xf0d6, fontFamily: 'fa');

  static fromUnicode(int code) {
    return IconData(code, fontFamily: 'fa');
  }
}
