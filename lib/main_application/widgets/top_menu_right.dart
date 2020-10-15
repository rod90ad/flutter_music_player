import 'dart:math';

import 'package:flutter/material.dart';

class TopMenuRight extends StatelessWidget {
  final Animation marginRight;

  TopMenuRight(this.marginRight);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Transform.translate(
      offset: Offset((width - 50) + (50 * marginRight.value), 10),
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: IconButton(
              onPressed: () {
                print("abrir menu");
              },
              icon:
                  Icon(Icons.short_text_sharp, color: Colors.black, size: 33))),
    );
  }
}
