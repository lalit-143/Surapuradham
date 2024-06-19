import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:surapuradham/Screens/about_page.dart';
import 'package:surapuradham/Screens/booking_page.dart';
import 'package:surapuradham/Screens/contact_page.dart';
import 'package:surapuradham/Screens/home_page.dart';
import 'package:surapuradham/Screens/language_screen.dart';
import 'package:surapuradham/helper/google_ads.dart';
import 'package:surapuradham/helper/language_lists.dart';
import 'package:surapuradham/widgets/listtile_animation.dart';

class HomeScreenBase extends StatefulWidget {
  const HomeScreenBase({Key? key, required this.selected_language})
      : super(key: key);

  final String selected_language;

  @override
  _HomeScreenBaseState createState() => _HomeScreenBaseState();
}

class _HomeScreenBaseState extends State<HomeScreenBase> {
  double value = 0;
  double _borderRadius = 0;
  String selectedMenu = 'about';
  IconData icon = Icons.menu;

  Widget getSelectedPage() {
    switch (selectedMenu) {
      case 'booking':
        return BookingPage(selected_language: widget.selected_language);
      case 'about':
        return AboutPage(selected_language: widget.selected_language);
      case 'contact':
        return ContactPage(selected_language: widget.selected_language);
      default:
        return HomePage(selected_language: widget.selected_language);
    }
  }

  closeDrawer() {
    value = 0;
    _borderRadius = 0;
    icon = Icons.menu;
  }

  openDrawer() {
    value = 1;
    _borderRadius = 25;
    icon = Icons.close;
  }

  @override
  Widget build(BuildContext context) {
    Language language = Language();
    Map<String, String> lng = language.getLanguageMap(widget.selected_language);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 190, 208, 193),
                  Color.fromARGB(255, 199, 189, 206),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails e) {
                  // Adjust sensitivity by multiplying e.delta.dx with a factor
                  double sensitivityFactor = 5; // Adjust this value as needed
                  if (e.delta.dx > sensitivityFactor) {
                    setState(() {
                      openDrawer();
                    });
                  } else if (e.delta.dx < -sensitivityFactor) {
                    setState(() {
                      closeDrawer();
                    });
                  }
                },
              ),
            ),
            SafeArea(
                child: SingleChildScrollView(
              child: Container(
                width: 200,
                // color: Colors.amberAccent,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 2))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 125,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.asset('assets/images/stlogo2.png'),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(lng['home']!),
                      leading: const Icon(Icons.home),
                      selected: (selectedMenu == "home"),
                      selectedColor: Colors.teal.shade800,
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          selectedMenu = 'home';
                        });
                      },
                    ),
                    AnimatedListItem(
                      text: lng['booking']!,
                      iconData: Icons.calendar_month_rounded,
                      selected: (selectedMenu == "booking"),
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          selectedMenu = 'booking';
                        });
                      },
                    ),
                    ListTile(
                      title: Text(lng['about']!),
                      leading: Icon(Icons.info),
                      selected: (selectedMenu == "about"),
                      selectedColor: Colors.teal.shade800,
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          selectedMenu = 'about';
                        });
                      },
                    ),
                    ListTile(
                      title: Text(lng['contactus']!),
                      leading: Icon(Icons.contact_support_rounded),
                      selected: (selectedMenu == "contact"),
                      selectedColor: Colors.teal.shade800,
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          selectedMenu = 'contact';
                        });
                      },
                    ),
                    ListTile(
                      title: Text(lng['settings']!),
                      leading: Icon(Icons.settings),
                      selected: (selectedMenu == "settings"),
                      selectedColor: Colors.teal.shade800,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              duration: const Duration(milliseconds: 800),
                              type: PageTransitionType.rightToLeftWithFade,
                              alignment: Alignment.topCenter,
                              child: const LanguageScreen()),
                        );

                        setState(() {
                          closeDrawer();
                          selectedMenu = 'settings';
                        });
                      },
                    ),
                  ],
                ),
              ),
            )),
            TweenAnimationBuilder(
                curve: Curves.easeInOut,
                tween: Tween<double>(begin: 0, end: value),
                duration: const Duration(milliseconds: 500),
                builder: (_, double val, __) {
                  return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 180 * val)
                      ..rotateY((pi / 6) * val),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          _borderRadius), // Set the desired border radius
                      child: Scaffold(
                        backgroundColor: Color.fromARGB(255, 234, 223, 209),
                        appBar: AppBar(
                          scrolledUnderElevation: 0,
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                if (value == 0) {
                                  openDrawer();
                                } else {
                                  closeDrawer();
                                }
                              });
                            },
                            icon: Icon(icon),
                          ),
                          centerTitle: true,
                          title: GestureDetector(
                            onDoubleTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                "Devloped By, Lalit Chaudhary ( LK )",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              )));
                            },
                            onHorizontalDragUpdate: (DragUpdateDetails e) {
                              // Adjust sensitivity by multiplying e.delta.dx with a factor
                              double sensitivityFactor =
                                  5; // Adjust this value as needed
                              if (e.delta.dx > sensitivityFactor) {
                                setState(() {
                                  openDrawer();
                                });
                              } else if (e.delta.dx < -sensitivityFactor) {
                                setState(() {
                                  closeDrawer();
                                });
                              }
                            },
                            child: Text(
                              lng['name']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.deepOrange.shade200,
                        ),
                        body: getSelectedPage(),
                      ),
                    ),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
