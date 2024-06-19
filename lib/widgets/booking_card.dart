import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(
      {super.key,
      required this.userName,
      required this.userNumber,
      required this.userCity, required this.bookingDate, required this.lng});

  final String userName;
  final String userNumber;
  final String userCity;
  final String bookingDate;
  final Map<String, String> lng;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: 280,
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: const Border(
              top: BorderSide(
                  color: Color.fromARGB(255, 234, 223, 209), width: 1),
              bottom: BorderSide(
                  color: Color.fromARGB(255, 234, 223, 209), width: 1),
              left: BorderSide(
                  color: Color.fromARGB(255, 234, 223, 209), width: 1),
              right: BorderSide(
                  color: Color.fromARGB(255, 234, 223, 209), width: 1)),
          image: const DecorationImage(
              image: AssetImage("assets/images/idcard.png"), fit: BoxFit.fill),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 35),
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage("assets/images/stlogo2.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 230,
                  child: Text(
                    userName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.brown.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(0)),
                      ),
                      child: Icon(
                        Icons.phone,
                        size: 18,
                        color: Colors.blueGrey.shade600,
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade50,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(0),
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        userNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(0),
                        ),
                      ),
                      child: Icon(
                        Icons.location_city,
                        size: 18,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(0),
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        userCity,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(0),
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        size: 18,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(0),
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        bookingDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 38),
              ],
            ),
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat()).shimmer(
            duration: const Duration(milliseconds: 1500),
            delay: const Duration(milliseconds: 1500),
            angle: 120,
          ),
    );
  }
}
