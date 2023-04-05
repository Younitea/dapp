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

  void _rollSkill(String skill, bool prof, bool exp, int bonus) {
    //todo, ouput skill
    return;
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
            Container(
              height: 30,
              width: 200,
              color: Colors.yellow,
              child: Center(
                  child: FloatingActionButton(
                heroTag: "SkillA",
                onPressed: () {
                  _rollSkill('str', false, false, 0);
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                elevation: 0,
                tooltip: 'Roll Skill',
                child: const Text('Skill A'),
              )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
