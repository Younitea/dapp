import 'package:flutter/material.dart';

class SelectView extends StatefulWidget {
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select View"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/player_view'),
                child:
                    const Text("Player View", style: TextStyle(fontSize: 36))),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/gm_view'),
                child: const Text("GM View", style: TextStyle(fontSize: 36))),
          ],
        ),
      ),
    );
  }
}
