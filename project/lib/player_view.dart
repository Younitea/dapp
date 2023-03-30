import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final box = GetStorage();
  late String _playerName;

  @override
  void initState() {
    super.initState();
    _playerName = box.read("playerName") ?? "Click to edit name";
  }

  @override
  void dispose() {
    box.write(_playerName, "playerName");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the Player View page!",
                style: TextStyle(fontSize: 24)),
            EditableText(
              controller: TextEditingController(text: _playerName),
              focusNode: FocusNode(),
              style: const TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              backgroundCursorColor: Colors.black,
              onSubmitted: (value) => setState(() {
                _playerName = value;
                box.write("playerName", value);
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
