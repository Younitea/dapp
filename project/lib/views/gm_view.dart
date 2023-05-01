import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:project/miles_widgets/camera_view.dart';
import '../miles_widgets/miles_widget.dart';

class GmView extends ConsumerWidget {
  const GmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const MilesWidget();
            break;
          case '/camera_view':
            builder = (BuildContext _) => const CameraView();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
