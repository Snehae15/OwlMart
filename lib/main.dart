import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:owlmart/app/app.dart';
import 'package:owlmart/core/di/injection.dart' as di;
import 'package:owlmart/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }
  await di.init();
  runApp(const OwlMartApp());
}
