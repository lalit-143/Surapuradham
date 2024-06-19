import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingForm extends StatefulWidget {
  const BookingForm(
      {super.key, required this.updateShowForm, required this.lng});

  final Function(String) updateShowForm;
  final Map<String, String> lng;

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _animation;
  final bool _isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          content: Container(
            height: 230,
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50.withOpacity(0.85),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(0),
                top: Radius.circular(35),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Lottie.asset(
                      'assets/lottie/booking_success.json',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      repeat: false,
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              widget.lng['congratulations_your_turn']!,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey.shade700,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.lng['now_you_can_see_your_booking_card']!,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey.shade500,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.lng[
                                  'note_booking_card_is_required_for_entry']!,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade100.withOpacity(0.85),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  widget.lng['okay']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
        );
      },
    );
  }

  void _showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          content: Container(
            height: 230,
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50.withOpacity(0.85),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(0),
                top: Radius.circular(35),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: -30,
                    width: 300,
                    height: 300,
                    child: Opacity(
                      opacity: 0.07,
                      child: Lottie.asset(
                        'assets/lottie/booking_sorry.json',
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        repeat: false,
                      ),
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              widget
                                  .lng['sorry_your_turn_could_not_be_booked']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.lng[
                                  'please_try_again_in_next_booking_session']!,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey.shade500,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.lng['tip_you_should_be']!,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade100.withOpacity(0.85),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  widget.lng['okay']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var lng = widget.lng;

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10.0),
            FadeTransition(
              opacity: _animation,
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: lng['full_name'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lng['please_enter_your_full_name'];
                  }
                  if (value.contains(RegExp(r'\d'))) {
                    return lng['full_name_should_not_contain_digits'];
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            FadeTransition(
              opacity: _animation,
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  labelText: lng['mobile_number'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lng['please_enter_your_mobile_number'];
                  }
                  if (!value.contains(RegExp(r'^[0-9]+$'))) {
                    return lng['mobile_number_should_only_contain_digits'];
                  }
                  if (value.trim().length < 10) {
                    return lng['mobile_number_must_be_at_least_10_digits'];
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 20.0),
            FadeTransition(
              opacity: _animation,
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: lng['city_village'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                  prefixIcon: const Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lng['please_enter_your_city_or_village'];
                  }
                  if (value.contains(RegExp(r'\d'))) {
                    return lng['city_or_village_should_not_contain_digits'];
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30.0),
            FadeTransition(
              opacity: _animation,
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade100,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: _isLoading
                    ? Container(
                        width: 20.0,
                        height: 20.0,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      )
                    : Text(
                        lng['book_now']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.blueGrey.shade700),
                      ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    // widget.updateShowForm("Updated");
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final mobileNumber = _mobileNumberController.text;
      final city = _cityController.text;
      _showSuccessDialog(context);
      _saveIsBooked(userName, mobileNumber, city);
    } else {
      _showFailedDialog(context);
    }
  }

  Future<void> _saveIsBooked(
      String userName, String mobileNumber, String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isBooked", true);
    await prefs.setString("userName", userName);
    await prefs.setString("userNumber", mobileNumber);
    await prefs.setString("userCity", city);

    DateTime currentTime = await NTP.now();

    String bookingExpireTime =
        currentTime.add(const Duration(seconds: 50)).toString();
    await prefs.setString("bookingExpireTime", bookingExpireTime);
    await prefs.setString("bookingDate",
        "${currentTime.day.toString().padLeft(2, '0')}-${currentTime.month.toString().padLeft(2, '0')}-${currentTime.year}");
  }
}
