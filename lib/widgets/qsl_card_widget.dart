import 'package:flutter/material.dart';

class QslCardWidget extends StatefulWidget {
  final String imagePath;

  const QslCardWidget({required this.imagePath, super.key});

  @override
  _QslCardWidgetState createState() => _QslCardWidgetState();
}

class _QslCardWidgetState extends State<QslCardWidget> {
  bool _isTappingDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isTappingDown = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTappingDown = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTappingDown = false;
        });
      },
      child: AnimatedScale(
        scale: _isTappingDown ? 1.4 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Image.asset(
          widget.imagePath,
          fit: BoxFit.fitHeight,
          height: 200, // 设置合适的高度
        ),
      ),
    );
  }
}