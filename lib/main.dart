import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/hatzolah.dart';

import 'core/dependencies.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection().init();
  runApp(const Hatzolah());
}