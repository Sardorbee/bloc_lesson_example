import 'package:flutter/material.dart';

class InternetErrorPage extends StatelessWidget {
  const InternetErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Internet bilan bog'lanishda xatolik sodir bo'ldi",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
