import 'package:flutter/material.dart';
import 'package:surapuradham/helper/language_lists.dart';
import 'package:surapuradham/widgets/listtile_contact.dart';
import 'package:surapuradham/widgets/map_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.selected_language});

  final String selected_language;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Language language = Language();
    Map<String, String> lng = language.getLanguageMap(widget.selected_language);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              color: Colors.transparent,
              child: const MapScreen(),
            ),
            GestureDetector(
              onTap: () {
                googleMapsIntent();
              },
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.blueGrey.shade50.withOpacity(0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          lng['view_directions']!,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                          ),
                        )
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 10),
            ListtileContact(
              title: lng['location']!,
              subtitle: lng['contact_address']!,
              leadicon: Icons.location_on,
            ),
            ListtileContact(
              title: lng['email_id']!,
              subtitle: "surapuradham01gmail.com",
              leadicon: Icons.email,
            ),
            Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.orange.shade50.withOpacity(0.5),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  lng['reach_out_us']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade600),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _userNameController,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.brown.shade900,
                  ),
                  label: Center(
                    child: Text(
                      lng["enter_your_full_name"]!,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    showSnackBar(lng['please_enter_your_full_name']!);
                    return null;
                  }
                  if (value.contains(RegExp(r'\d'))) {
                    showSnackBar(lng['full_name_should_not_contain_digits']!);
                    return null;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _userEmailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  label: Center(
                    child: Text(
                      lng['enter_your_email_address']!,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    showSnackBar(lng['please_enter_your_email_address']!);
                    return null;
                  }

                  final RegExp emailRegExp = RegExp(
                      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

                  if (!emailRegExp.hasMatch(value)) {
                    showSnackBar(lng['please_enter_valid_email_address']!);
                    return null;
                  }

                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                controller: _messageController,
                maxLines: 5,
                minLines: 1,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  label: Center(
                    child: Text(
                      lng['enter_your_message']!,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.deepPurple.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    showSnackBar(lng['please_enter_your_message']!);
                    return null;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                        lng['send_message']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.blueGrey.shade700),
                      ),
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  void showSnackBar(String error) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 5),
      backgroundColor: Colors.redAccent.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      content: Text(
        error,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final mobileNumber = _userEmailController.text;
      final message = _messageController.text;
    }
  }

  void googleMapsIntent() async {
    const fallbackUrl =
        'https://www.google.com/maps/dir//22.45544,72.276125/@22.4555432,72.2753879,17z';
    final googleMapsUri = Uri.parse('geo:22.45544,72.276125');
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      final fallbackUri = Uri.parse(fallbackUrl);
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri);
      } else {
        debugPrint('Fallback URL is not available.');
      }
    }
  }
}
