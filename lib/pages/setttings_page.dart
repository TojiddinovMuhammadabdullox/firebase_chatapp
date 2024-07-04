import 'package:flutter/material.dart';

class SetttingsPage extends StatelessWidget {
  const SetttingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text("Settings Page"),
      ),
    );
  }
}
