import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';

class AbdominalPainScreen extends StatefulWidget {
  const AbdominalPainScreen({Key? key}) : super(key: key);

  @override
  State<AbdominalPainScreen> createState() => _AbdominalPainScreenState();
}

class _AbdominalPainScreenState extends State<AbdominalPainScreen> {
  bool _patientAlert = false;
  bool _troubleBreathing = false;
  bool _bleeding = false;
  bool _dizzyrOrFaint = false;
  bool _pale = false;
  bool _chestPain = false;
  bool _recentSurgery = false;
  bool _recentVomiting = false;

  _createCall() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abdominal Pain"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Please answer the following questions", style: TextStyle(fontSize: 16),),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Is the patient alert?'),
                  value: _patientAlert,
                  onChanged: (bool value) {
                    setState(() {
                      _patientAlert = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Does the patient have any trouble breathing?'),
                  value: _troubleBreathing,
                  onChanged: (bool value) {
                    setState(() {
                      _troubleBreathing = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Is the patient bleeding from anywhere?'),
                  value: _bleeding,
                  onChanged: (bool value) {
                    setState(() {
                      _bleeding = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Is the patient feeling dizzy, faint or sweaty? '),
                  value: _dizzyrOrFaint,
                  onChanged: (bool value) {
                    setState(() {
                      _dizzyrOrFaint = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Is the patient pale? '),
                  value: _pale,
                  onChanged: (bool value) {
                    setState(() {
                      _pale = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Does the patient have any chest pain or chest discomfort? '),
                  value: _chestPain,
                  onChanged: (bool value) {
                    setState(() {
                      _chestPain = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Has the patient had any recent surgery or injury to the abdomen?'),
                  value: _recentSurgery,
                  onChanged: (bool value) {
                    setState(() {
                      _recentSurgery = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: SwitchListTile(
                  title: const Text('Is the patient vomiting?'),
                  value: _recentVomiting,
                  onChanged: (bool value) {
                    setState(() {
                      _recentVomiting = value;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _createCall(),
                child: const Text("Dispatch"),
                style: ElevatedButton.styleFrom(
                  primary: primaryColour,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
