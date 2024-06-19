import 'dart:math' as math;
import 'package:flutter/material.dart';

class WavyClipart extends StatelessWidget {
  final Color color;
  final double waveHeight;
  final double waveLength;
  final bool isTopWave;

  const WavyClipart({
    Key? key,
    required this.color,
    required this.waveHeight,
    required this.waveLength,
    required this.isTopWave, // Default value is set to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WavyClipper(
        waveHeight: waveHeight,
        waveLength: waveLength,
        isTopWave: isTopWave,
      ),
      child: Container(
        color: color,
        height: 15,
      ),
    );
  }
}

class WavyClipper extends CustomClipper<Path> {
  final double waveHeight;
  final double waveLength;
  final bool isTopWave;

  WavyClipper({
    required this.waveHeight,
    required this.waveLength,
    this.isTopWave = false, // Default value is set to false
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    if (isTopWave) {
      path.moveTo(0, size.height - waveHeight);
    } else {
      path.moveTo(0, waveHeight);
    }

    for (double i = 0; i < size.width; i++) {
      if (isTopWave) {
        path.lineTo(
          i,
          size.height -
              (math.sin((i / waveLength) * 2 * math.pi) * waveHeight +
                  waveHeight),
        );
      } else {
        path.lineTo(
          i,
          math.sin((i / waveLength) * 2 * math.pi) * waveHeight + waveHeight,
        );
      }
    }

    if (isTopWave) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
