import 'package:flutter/material.dart';

class BiteAndStingsScreen extends StatefulWidget {
  const BiteAndStingsScreen({Key? key}) : super(key: key);

  @override
  State<BiteAndStingsScreen> createState() => _BiteAndStingsScreenState();
}

class _BiteAndStingsScreenState extends State<BiteAndStingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bite and Stings"),
      ),
      body: Container(
        child: Text("BiteAndStingsScreen"),
      ),
    );
  }
}
