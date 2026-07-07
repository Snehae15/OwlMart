import 'package:flutter/material.dart';
import 'package:owlmart/app/app.dart';
import 'package:owlmart/core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const OwlMartApp());
}
