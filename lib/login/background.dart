import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 2,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset("assets/images/skin_side_up.png",),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset("assets/images/skin_side_up.png",),
          ),
          Positioned(
            right: 0,
            child: Image.asset("assets/images/skin_side_up.png",),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset("assets/images/skin_side_up.png",),
          ),
          // Positioned(
          //   bottom: 0,
          //   child: Image.asset("assets/images/bg-u33.png", width: size.width),
          // ),
          child
        ],
      ),
    );
  }
}
