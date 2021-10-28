import 'dart:math';

import 'package:flutter/material.dart';

class BezierController extends StatelessWidget {
  const BezierController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xff3E8DBA),
          ),
        ),
      ),
    );
  }
}
