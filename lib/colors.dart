import 'dart:ui';

enum CustomColor {
  white,
  gray,
  fadedBlue,
  sourCherryPink,
  pavementPink,
  smoothBlack,
  bestPink,
  fantasticBlue,
}

extension CustomColorExtension on CustomColor {
  Color get color {
    switch (this) {
      case CustomColor.white:
        return const Color(0xFFDFEDFF);
      case CustomColor.gray:
        return const Color(0xFF818E9F);
      case CustomColor.fadedBlue:
        return const Color(0xFF476995);
      case CustomColor.sourCherryPink:
        return const Color(0xFF360A15);
      case CustomColor.pavementPink:
        return const Color(0xFF120B0D);
      case CustomColor.smoothBlack:
        return const Color(0xFF0A0506);
      case CustomColor.bestPink:
        return const Color(0xFFD8055E);
      case CustomColor.fantasticBlue:
        return const Color(0xFF2374AB);
    }
  }
}