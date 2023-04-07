import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class Skill {
  String skillName = '';
  bool prof = false;
  bool expert = false;
  int stat = 0;
  Skill(this.skillName, this.prof, this.expert, this.stat);
}

class _PlayerViewState extends State<PlayerView> {
  final box = GetStorage();
  late String _playerName;
  List<Skill> skillList = [
    Skill("acrobatics", true, false, 1),
    Skill("athletics", false, false, 0)
  ]; //needs to be stored eventually

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
            SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: skillList.length,
                    prototypeItem: ListTile(
                      title: Text(skillList.first.skillName),
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(skillList[index].skillName));
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
