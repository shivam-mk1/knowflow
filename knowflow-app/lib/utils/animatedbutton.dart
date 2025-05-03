import 'package:flutter/material.dart';

class ShakingIconButton extends StatefulWidget {
  final void onTap;
  const ShakingIconButton({super.key, this.onTap});

  @override
  State<ShakingIconButton> createState() => _ShakingIconButtonState();
}

class _ShakingIconButtonState extends State<ShakingIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: IconButton(
            onPressed: () {
              widget.onTap;
            },
            icon: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
