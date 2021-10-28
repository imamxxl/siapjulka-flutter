import 'package:flutter/material.dart';

class Pallete {
  static MaterialColor blueElectronica = const MaterialColor(
    0xff3e8dba, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff387fa7), //10%
      100: Color(0xff327195), //20%
      200: Color(0xff2b6382), //30%
      300: Color(0xff255570), //40%
      400: Color(0xff1f475d), //50%
      500: Color(0xff19384a), //60%
      600: Color(0xff132a38), //70%
      700: Color(0xff0c1c25), //80%
      800: Color(0xff060e13), //90%
      900: Color(0xff000000), //100%
    },
  );
}
