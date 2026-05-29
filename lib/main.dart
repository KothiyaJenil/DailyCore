import 'package:dailycore/app.dart';
import 'package:dailycore/firebase_options.dart';
import 'package:dailycore/providers/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(AppProvider(child: const MyApp()));
}
