import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CountdownSlider extends StatefulWidget {

  CountdownSlider({super.key, required this.formStartTime, required this.lng});

  final DateTime formStartTime;
  final Map<String, String> lng;

  @override
  _CountdownSliderState createState() => _CountdownSliderState();
}

class _CountdownSliderState extends State<CountdownSlider> {

  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTime();
  }

  Future<void> _fetchTime() async {
    DateTime myTime = await NTP.now();
    if(mounted){
      setState(() {
        currentTime = myTime;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Duration remainingTime = widget.formStartTime.difference(currentTime);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          SlideCountdownSeparated(
            duration: remainingTime,
            slideDirection: SlideDirection.down,
            style: TextStyle(fontSize: 18, color: Colors.white),
            separator: " ",
            showZeroValue: true,
            separatorType: SeparatorType.symbol,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18.2),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 196, 157, 133),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 257,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 57,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 133, 196, 181),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Text(
                    widget.lng['day']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                Container(
                  width: 57,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 133, 196, 181),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Text(
                    widget.lng['hour']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                Container(
                  width: 57,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 133, 196, 181),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Text(
                    widget.lng['minute']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                Container(
                  width: 57,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 133, 196, 181),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Text(
                    widget.lng['second']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
