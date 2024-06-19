import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  final bool selected;

  AnimatedListItem({
    required this.text,
    required this.iconData,
    required this.onTap,
    this.selected = false,
  });

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 777),
    )..repeat(reverse: true);

    _shakeAnimation = Tween(begin: -0.10, end: 0.10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _controller.value,
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjust font size as needed
            ),
          );
        },
      ),
      leading: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _shakeAnimation.value,
            child: Icon(
              widget.iconData,
            ),
          );
        },
      ),
      selected: widget.selected,
      selectedColor: Colors.teal.shade800,
      onTap: () {
        widget.onTap();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
