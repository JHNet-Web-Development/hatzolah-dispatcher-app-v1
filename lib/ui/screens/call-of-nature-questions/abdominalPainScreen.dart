import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/call-status-list.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/constants/question-list.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/models/question-models/abdominal-pain-questions.dart';
import 'package:uuid/uuid.dart';

class AbdominalPainScreen extends StatefulWidget {
  final Call? call;
  const AbdominalPainScreen({Key? key, this.call}) : super(key: key);

  @override
  State<AbdominalPainScreen> createState() => _AbdominalPainScreenState();
}

class _AbdominalPainScreenState extends State<AbdominalPainScreen> {
  final _formKey = GlobalKey<FormState>();
  final CallsCubit _callsCubit = sl<CallsCubit>();

  Patient? _currentPatient;
  final TextEditingController addressController = TextEditingController();
  bool _patientAlert = false;
  bool _troubleBreathing = false;
  bool _bleeding = false;
  bool _dizzyOrFaint = false;
  bool _pale = false;
  bool _chestPain = false;
  bool _recentSurgery = false;
  bool _recentVomiting = false;

  _createCall() {
    FocusScope.of(context).unfocus();
    var questions = AbdominalPainQuestions(
        patientAlert: _patientAlert,
        troubleBreathing: _troubleBreathing,
        bleeding: _bleeding,
        dizzyOrFaint: _dizzyOrFaint,
        pale: _pale,
        chestPain: _chestPain,
        recentSurgery: _recentSurgery,
        recentVomiting: _recentVomiting
    );
    _callsCubit.createUpdateCall(Call(
        id: const Uuid().v4(),
        patient: Patient(
            id: _currentPatient!.id,
            firstName: _currentPatient!.firstName,
            lastName: _currentPatient!.lastName,
            createdDate: _currentPatient!.createdDate
        ),
        address: addressController.text.trim(),
        questionType: QuestionList.abdominalPain.index,
        questions: questions,
        userId: null,
        status: CallStatusList.dispatched.index,
        dispatchedDate: Timestamp.now(),
    ));
  }

  @override
  void initState() {
    _callsCubit.getAllPatients();
    super.initState();

    AbdominalPainQuestions? questions = widget.call?.questions;

    //Set edit call variables
    _currentPatient = widget.call?.patient;
    addressController.text = widget.call?.address??"";
    _patientAlert = questions != null ? questions.patientAlert : false;
    _troubleBreathing = questions != null ? questions.troubleBreathing : false;
    _bleeding = questions != null ? questions.bleeding : false;
    _dizzyOrFaint = questions != null ? questions.dizzyOrFaint : false;
    _pale = questions != null ? questions.pale : false;
    _chestPain = questions != null ? questions.chestPain : false;
    _recentSurgery = questions != null ? questions.recentSurgery : false;
    _recentVomiting = questions != null ? questions.recentVomiting : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallsCubit, CallsState>(
      bloc: _callsCubit,
      listener: (context, state) {
        if (state is CallUpdated) {
          const snackBar = SnackBar(
            content: Text('Yay! Call created!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      },
  child: Scaffold(
      appBar: AppBar(
        title: const Text("Abdominal Pain"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Patient Details", style: TextStyle(fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 5, right: 5, bottom: 10),
                  child: BlocBuilder<CallsCubit, CallsState>(
                    bloc: _callsCubit,
                    builder: (context, state) {
                      List<Patient> patients = state.mainCallsState.patients;
                      return DropdownButtonFormField(
                        value: _currentPatient,
                        hint: const Text(
                          'Please select a Patient',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Patient Required";
                          } else {
                            return null;
                          }
                        },
                        items: patients.map((Patient patient) {
                          return DropdownMenuItem<Patient>(
                            value: patient,
                            child: Text(
                                patient.firstName + " " + patient.lastName),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Patient",
                        ),
                        onChanged: (value) {
                          _currentPatient = value as Patient;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(5.0),
                        borderSide:  const BorderSide(),
                      ),
                      labelText: "Address",
                      hintText: "29 Durham St, Sydenham, Johannesburg, 2192",
                    ),
                    controller: addressController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Address is Required';
                      }
                      return null;
                    },
                  ),
                ),
                const Text("Please answer the following questions", style: TextStyle(fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 5, right: 5, bottom: 10),
                  child: SwitchListTile(
                    title: const Text('Is the patient alert?'),
                    value: _patientAlert,
                    onChanged: (bool value) {
                      setState(() {
                        _patientAlert = value;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                  child: SwitchListTile(
                    title: const Text('Is the patient feeling dizzy, faint or sweaty? '),
                    value: _dizzyOrFaint,
                    onChanged: (bool value) {
                      setState(() {
                        _dizzyOrFaint = value;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.grey, width: 1)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _createCall(),
                  child: widget.call?.dispatchedDate == null ? const Text("Dispatch") : const Text("Update"),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColour,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
