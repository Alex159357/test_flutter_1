

import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final int rate;
  final double width;
  final double height;
  final Axis axis;
  const RateWidget({Key? key, required this.rate, required this.width, required this.height, this.axis = Axis.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child:
      axis == Axis.horizontal?
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _getRate,
      ) : axis == Axis.vertical? Column(
        children: _getRate,
      ) : Container(),
    );
  }

  List<Widget> get _getRate => List.generate(5, (index) => ClipOval(child: Container( width: 5, height: 5, color: index<= rate? Color(0xFFFFD646) : Color(0xFFE6E6E6),)));

}
