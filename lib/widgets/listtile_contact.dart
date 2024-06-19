import 'package:flutter/material.dart';

class ListtileContact extends StatelessWidget {
  const ListtileContact(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leadicon});

  final String title;
  final String subtitle;
  final IconData leadicon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: Colors.deepOrange.shade50.withOpacity(0.85),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        leading: Container(
          width: 45,
          height: 45,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            leadicon,
            color: Colors.brown.shade700,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        selectedColor: Colors.amber,
      ),
    );
  }
}
