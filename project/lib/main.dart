import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import 'miles_widgets/camera_view.dart';
import 'views/select_view.dart';
import 'views/player_view.dart';
import 'views/gm_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeCameras();
  HydratedRiverpod.initialize(
      storage: await HydratedStorage.build(
          storageDirectory: await getApplicationDocumentsDirectory()));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dungeons and Dragons for the Mathematically Impaired',
        initialRoute: '/',
        routes: {
          '/': (context) => const SelectView(),
      });
  }
}
