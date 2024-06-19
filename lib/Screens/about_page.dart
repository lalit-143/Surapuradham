import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:surapuradham/helper/language_lists.dart';
import 'package:surapuradham/widgets/animated_about_text.dart';
import 'package:surapuradham/widgets/youtube_widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.selected_language});

  final String selected_language;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;
  bool _isPlaying = false;
  bool _isScrolling = false;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _ticker = createTicker(_autoScroll);
  }

  Future<void> _playPause() async {
    _isPlaying = !_isPlaying;
    if (!_isPlaying) {
      _player.pause();
    } else {
      String audioSource = "audio/english.mp3";
      if (widget.selected_language == 'hindi') audioSource = "audio/hindi.mp3";
      if (widget.selected_language == 'gujarati') {
        audioSource = "audio/gujarati.mp3";
      }

      await _player.setSource(AssetSource(audioSource));
      await _player.resume();
      _player.onPlayerComplete.listen((event) {
        setState(() {
          _toggleScrolling();
          _isPlaying = false;
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastEaseInToSlowEaseOut,
          );
        });
      });
    }
  }

  void _toggleScrolling() {
    setState(() {
      _isScrolling = !_isScrolling;
      _isScrolling ? _ticker.start() : _ticker.stop();
    });
  }

  void _autoScroll(Duration elapsed) {
    double scrollSpeed = 0.215;
    if (widget.selected_language == 'hindi') scrollSpeed = 0.185;
    if (widget.selected_language == 'gujarati') scrollSpeed = 0.165;

    if (_isScrolling) {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentScrollPosition = _scrollController.offset;
      if (currentScrollPosition >= maxScrollExtent) {
        setState(() {
          _toggleScrolling();
        });
      } else {
        _scrollController.jumpTo(
          _scrollController.offset + scrollSpeed,
        );
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _scrollController.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Language language = Language();
    Map<String, String> lng = language.getLanguageMap(widget.selected_language);

    return Stack(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 220, bottom: 15, left: 15, right: 15),
          padding:
              const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 60),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: AnimatedText(
              selected_language: widget.selected_language,
            ),
          ),
        ),
        Positioned(
          child: (Platform.isAndroid || Platform.isIOS)
              ? Container(
                  width: double.maxFinite,
                  height: 190,
                  margin: const EdgeInsets.all(15),
                  child: const YouTubePlayerWidget(
                    videoUrl: "https://youtu.be/98sdcMpsxkM",
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  height: 190,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text(lng['youtube_video']!)),
                ),
        ),
        Positioned(
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.maxFinite,
              height: 205,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: const Border(
                    top: BorderSide(
                      color: Color.fromARGB(255, 234, 223, 209),
                      width: 10,
                    ),
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 234, 223, 209),
                      width: 10,
                    ),
                    left: BorderSide(
                      color: Color.fromARGB(255, 234, 223, 209),
                      width: 10,
                    ),
                    right: BorderSide(
                      color: Color.fromARGB(255, 234, 223, 209),
                      width: 10,
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          right: 25,
          left: 25,
          child: GestureDetector(
            onTap: () {
              _playPause();
              _toggleScrolling();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 100.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: _isPlaying
                      ? Colors.teal.shade200
                      : Colors.deepOrange.shade200,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15), right: Radius.circular(15))),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 35.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
