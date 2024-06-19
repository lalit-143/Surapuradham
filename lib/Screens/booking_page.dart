import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:lottie/lottie.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surapuradham/helper/language_lists.dart';
import 'package:surapuradham/widgets/booking_card.dart';
import 'package:surapuradham/widgets/booking_countdown.dart';
import 'package:surapuradham/widgets/booking_form.dart';
import 'package:surapuradham/widgets/wavy_clip.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.selected_language});

  final String selected_language;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Timer timer;
  bool showForm = false;
  bool isBooked = false;
  String userName = "";
  String userNumber = "";
  String userCity = "";
  String bookingDate = "";
  DateTime formStartTime = DateTime.now().add(const Duration(seconds: 30));
  DateTime formEndTime = DateTime.parse("2024-09-01 12:00:00");
  final _cardController = GestureFlipCardController();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
      }
      _fetchTimeAndCheck();
      _getIsBooked();
    });
  }

  Future<void> _getIsBooked() async {
    if (mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isBooked = prefs.getBool("isBooked") ?? false;
        if (isBooked) {
          userName = prefs.getString("userName") ?? "";
          userNumber = prefs.getString("userNumber") ?? "";
          userCity = prefs.getString("userCity") ?? "";
          bookingDate = prefs.getString("bookingDate") ?? "";
        }
      });
    }
  }

  Future<void> _fetchTimeAndCheck() async {
    DateTime currentTime = await NTP.now();
    _checkFormDisplay(currentTime);
    _checkBookingExpiry(currentTime);
  }

  Future<void> _checkBookingExpiry(DateTime currentTime) async {
    if (mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isBooked = prefs.getBool("isBooked") ?? false;
      if (isBooked) {
        String bookingExpireString = prefs.getString("bookingExpireTime") ?? "";
        DateTime bookingExpireTime = DateTime.parse(bookingExpireString);
        if (currentTime.isAfter(bookingExpireTime)) {
          await prefs.setBool("isBooked", false);
        }
      }
    }
  }

  void _checkFormDisplay(DateTime currentTime) {
    if (mounted) {
      if (currentTime.isAfter(formStartTime) &&
          currentTime.isBefore(formEndTime)) {
        setState(() {
          showForm = true;
        });
      } else {
        setState(() {
          showForm = false;
        });
      }
    }
  }

  void updateShowForm(String newValue) {
    setState(() {
      isBooked = true;
      showForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Language language = Language();
    Map<String, String> lng = language.getLanguageMap(widget.selected_language);

    double screenHeight = MediaQuery.of(context).size.height;
    double formBoxHeight = screenHeight - 100;

    if (screenHeight > 470) {
      formBoxHeight = 410;
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: WavyClipart(
            color: Colors.deepOrange.shade200,
            waveHeight: 5,
            waveLength: 160,
            isTopWave: false,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 225,
                color: Colors.grey.shade200,
                width: double.maxFinite,
                child: Lottie.asset(
                  'assets/lottie/booking_main.json',
                  alignment: Alignment.center,
                  repeat: false,
                ),
              ),
              SizedBox(
                height: 20,
                child: WavyClipart(
                  color: Colors.grey.shade200,
                  waveHeight: 5,
                  waveLength: 160,
                  isTopWave: false,
                ),
              ),
              const SizedBox(height: 20),
              if (!showForm && !isBooked)
                Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      elevation: 1,
                      color: Colors.white30.withOpacity(0.9),
                      child: Container(
                        width: 257,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          lng['the_booking_form_available_on_sunday_at_3pm']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Container(
                        width: 257,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          lng['time_left']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade600),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: CountdownSlider(
                            formStartTime: formStartTime, lng: lng)),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        if (showForm && !isBooked)
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: Colors.black.withOpacity(0.5),
          ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: WavyClipart(
            color: Colors.deepOrange.shade200,
            waveHeight: 5,
            waveLength: 160,
            isTopWave: false,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: (showForm && !isBooked) ? 0 : -1000,
          left: 0,
          right: 0,
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            duration: const Duration(milliseconds: 500),
            height: formBoxHeight,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                image: const DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/stlogo.png'),
                  opacity: 0.1,
                  fit: BoxFit.contain,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25))),
            child: BookingForm(updateShowForm: updateShowForm, lng: lng),
          ),
        ),
        if (isBooked)
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: Colors.black.withOpacity(0.5),
          ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: WavyClipart(
            color: Colors.deepOrange.shade200,
            waveHeight: 5,
            waveLength: 160,
            isTopWave: false,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: (isBooked) ? 0 : -1000,
          left: 0,
          right: 0,
          onEnd: () {
            _cardController.flipcard();
          },
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                image: const DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/stlogo.png'),
                  opacity: 0.1,
                  fit: BoxFit.contain,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30))),
            child: GestureFlipCard(
              animationDuration: const Duration(milliseconds: 1000),
              frontWidget: BookingCard(
                userName: userName,
                userNumber: userNumber,
                userCity: userCity,
                bookingDate: bookingDate,
                lng: lng,
              ),
              backWidget: BookingCard(
                userName: userName,
                userNumber: userNumber,
                userCity: userCity,
                bookingDate: bookingDate,
                lng: lng,
              ),
              controller: _cardController,
              enableController: true,
            ),
          ),
        ),
      ],
    );
  }
}
