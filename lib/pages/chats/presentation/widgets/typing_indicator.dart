import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        double value = (_controller.value * 3 - index);
        value = value.clamp(0.0, 1.0);

        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: Colors.grey.shade500,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_dot(0), _dot(1), _dot(2)],
        ),
      ),
    );
  }
}
