import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surapuradham/Screens/main_base.dart';

class LngBtn extends StatefulWidget {
  const LngBtn({super.key, required this.language, required this.language_img});

  final String language;
  final String language_img;

  @override
  State<LngBtn> createState() => _LngBtnState();
}

class _LngBtnState extends State<LngBtn> {

  Future<void> _saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _saveLanguage(widget.language_img);
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 750),
            type: PageTransitionType.leftToRightWithFade,
            alignment: Alignment.topCenter,
            child: HomeScreenBase(selected_language: widget.language_img,),
          ),
        );

      },
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black45,
                offset: Offset(2, 3),
                blurRadius: 5
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          image: DecorationImage(
              image: AssetImage('assets/language_img/${widget.language_img}.jpg'),
              opacity: 0.5,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.blueGrey.shade100, BlendMode.darken)),
        ),
        child: Center(
            child: Text(
              widget.language,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
