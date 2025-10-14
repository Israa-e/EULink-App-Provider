import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
var _shimmerGradient = LinearGradient(
  colors: [
   Get.isDarkMode ==  true ? Color(0xFF6D6D6E): Color(0xFFEBEBF4),
    Get.isDarkMode ==  true ? Color(0xFF6D6D6E):  Color(0xFFF4F4F4),
    Get.isDarkMode ==  true ? Color(0xFF6D6D6E):  Color(0xFFEBEBF4),
  ],


  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);