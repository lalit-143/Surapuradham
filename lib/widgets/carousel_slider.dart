import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';


class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {

  final List<String> images = [
    'assets/language_img/english.jpg',
    'assets/language_img/hindi.jpg',
    'assets/language_img/gujarati.jpg',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double aspectRatio = 1;
    double viewport = 0.75;
    double sliderHeight = 120;
    double sliderWidth = screenWidth;

    if(screenWidth > 300){
      viewport = 0.7;
      sliderHeight = 140;
    }

    if(screenWidth > 400){
      viewport = 0.7;
      sliderHeight = 160;
    }

    if(screenWidth > 500){
      viewport = 0.7;
      sliderHeight = 180;
    }
    if(screenWidth > 600){
      viewport = 0.6;
      sliderHeight = 200;
    }
    if(screenWidth > 800){
      viewport = 0.5;
      sliderHeight = 220;
    }

    if(screenWidth > 1000){
      viewport = 0.4;
      sliderHeight = 240;
    }

    if(screenWidth > 1500){
      viewport = 0.3;
      sliderHeight = 250;
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // color: Colors.red,
            height: sliderHeight,
            width: sliderWidth,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: aspectRatio,
                viewportFraction: viewport,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          DotsIndicator(
            dotsCount: images.length,
            position: _currentIndex,
            decorator: DotsDecorator(
              size: Size.square(9),
              activeSize: Size.square(9),
              color: Colors.black38,
              activeColor: Colors.deepOrangeAccent,
              spacing: EdgeInsets.all(5),
            ),
          ),
        ],
    );
  }
}
