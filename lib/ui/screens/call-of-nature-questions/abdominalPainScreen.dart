import 'package:flutter/material.dart';

class AbdominalPainScreen extends StatefulWidget {
  const AbdominalPainScreen({Key? key}) : super(key: key);

  @override
  State<AbdominalPainScreen> createState() => _AbdominalPainScreenState();
}

class _AbdominalPainScreenState extends State<AbdominalPainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abdominal Pain"),
      ),
      body: Container(
        child: Text("AbdominalPainScreen"),
      ),
    );
  }
}
