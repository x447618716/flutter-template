import 'package:flutter/material.dart';

class SpinningIconButton extends AnimatedWidget {
  const SpinningIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.controller,
    this.color,
    this.size = 20,
  }) : super(listenable: controller);

  final AnimationController controller;
  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
    );

    return RotationTransition(
      turns: animation,
      child: SizedBox(
        height: size,
        width: size,
        child: IconButton(
          color: color,
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            size: size,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
