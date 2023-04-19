import 'package:flutter/material.dart';

class GmView extends StatefulWidget {
  const GmView({super.key});
  @override
  State<GmView> createState() => _GmViewState();
}

class _GmViewState extends State<GmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/camera_view');
              },
              child: const Text("Welcome to the GM View page!",
                  style: TextStyle(fontSize: 24)))),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
