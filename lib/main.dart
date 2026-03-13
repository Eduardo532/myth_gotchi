import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/homeostasis_loop.dart';
import 'services/ble_multiplayer_service.dart';
import 'ui/screens/device_screen.dart';

// --- Inicialización ---

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MythGotchiApp());
}

// --- Aplicación Principal ---

class MythGotchiApp extends StatelessWidget {
  const MythGotchiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeostasisLoop(),
        ),
        ChangeNotifierProvider(
          create: (_) => BleMultiplayerService(),
        ),
      ],
      child: MaterialApp(
        title: 'MythGotchi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFF8BA69C),
          fontFamily: 'Courier',
        ),
        home: const DeviceScreen(),
      ),
    );
  }
}