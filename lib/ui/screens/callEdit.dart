import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/callPatientVitals.dart';

class CallEditScreen extends StatefulWidget {
  final Call call;
  const CallEditScreen({Key? key, required this.call}) : super(key: key);

  @override
  State<CallEditScreen> createState() => _CallEditScreenState();
}

class _CallEditScreenState extends State<CallEditScreen> {
  // cubits
  final CallsCubit _callsCubit = sl<CallsCubit>();

  // Controllers
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _saveInfo(Call call) {
    FocusScope.of(context).unfocus();
    _callsCubit.createUpdateCall(call.copyWith(patientVitals: CallPatientVitals(bloodPressure: double.parse(bloodPressureController.text.trim()), temperature: double.parse(temperatureController.text.trim()))));
  }

  @override
  void initState() {
    super.initState();
    bloodPressureController.text = widget.call.patientVitals?.bloodPressure?.toString() ?? "";
    temperatureController.text = widget.call.patientVitals?.temperature?.toString() ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CallsCubit, CallsState>(
      bloc: _callsCubit,
      listener: (context, state) {
        if(state is CallUpdated){
          const snackBar = SnackBar(
            content: Text('Yay! Call completed!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) => Navigator.pop(context));
        }
  },
  child: Scaffold(
        appBar: AppBar(
          title: Text("Call in progress for - ${widget.call.patient.firstName } ${widget.call.patient.lastName}"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Text(widget.call.patient.firstName + " " + widget.call.patient.lastName),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(5.0),
                          borderSide:  const BorderSide(),
                        ),
                        labelText: "Blood Pressure",
                        hintText: "125.5",
                      ),
                      keyboardType: TextInputType.number,
                      controller: bloodPressureController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Blood pressure is empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(5.0),
                          borderSide:  const BorderSide(),
                        ),
                        labelText: "Temperature",
                        hintText: "36.3",
                      ),
                      keyboardType: TextInputType.number,
                      controller: temperatureController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Temperature is empty';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _formKey.currentState!.validate() ? _saveInfo(widget.call) : null,
                      child: const Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        primary: primaryColour,
                      ),
                    )
                  ],
                ),
              ),
            ],),
          ),
        )
    ),
);
  }
}
