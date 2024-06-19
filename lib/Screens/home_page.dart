import 'dart:io';
import 'package:flutter/material.dart';
import 'package:surapuradham/helper/google_ads.dart';
import 'package:surapuradham/widgets/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.selected_language}) : super(key: key);

  final String selected_language;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CarouselDemo(),
              const SizedBox(height: 20),
            ],
          ),
        ),
        if (Platform.isAndroid || Platform.isIOS)
          const Align(
            alignment: Alignment.bottomCenter,
            child: ShowBannerAd(),
          )
      ],
    );
  }
}
