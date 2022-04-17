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
import 'package:hatzolah_dispatcher_app/models/question-models/bites-and-stings-questions.dart';
import 'package:uuid/uuid.dart';

class BiteAndStingsScreen extends StatefulWidget {
  const BiteAndStingsScreen({Key? key}) : super(key: key);

  @override
  State<BiteAndStingsScreen> createState() => _BiteAndStingsScreenState();
}

class _BiteAndStingsScreenState extends State<BiteAndStingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final CallsCubit _callsCubit = sl<CallsCubit>();

  String? _currentPatientId;
  final TextEditingController addressController = TextEditingController();
  bool _patientAlert = false;
  bool _troubleBreathing = false;
  bool _troubleSwallowing = false;
  bool _tightnessThroatOrChest = false;
  bool _dizzyFaintOrSweaty = false;
  bool _pale = false;
  bool _historyAllergicReactions = false;

  @override
  void initState() {
    _callsCubit.getAllPatients();
    super.initState();
  }

  _createCall() {
    FocusScope.of(context).unfocus();
    var questions = BitesAndStingsQuestions(
        patientAlert: _patientAlert,
        troubleBreathing: _troubleBreathing,
        troubleSwallowing: _troubleSwallowing,
        tightnessThroatOrChest: _tightnessThroatOrChest,
        dizzyFaintOrSweaty: _dizzyFaintOrSweaty,
        pale: _pale,
        historyAllergicReactions: _historyAllergicReactions);
    _callsCubit.createUpdateCall(Call(
        id: const Uuid().v4(),
        patientId: _currentPatientId!,
        patient: Patient(
            id: "1o4Ne6GsML51CAUuqEmp",
            firstName: "John",
            lastName: "Doe",
            createdDate: Timestamp.now()),
        address: addressController.value.toString().trim(),
        questionType: QuestionList.bitesAndStings.index,
        questions: questions,
        userId: null,
        status: CallStatusList.dispatched.index,
        createdDate: Timestamp.now()));
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
          title: const Text("Bite and Stings"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Patient Details",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 5, right: 5, bottom: 10),
                    child: BlocBuilder<CallsCubit, CallsState>(
                      bloc: _callsCubit,
                      builder: (context, state) {
                        List<Patient> patients = state.mainCallsState.patients;
                        return DropdownButtonFormField(
                          value: _currentPatientId,
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
                            return DropdownMenuItem<String>(
                              value: patient.id,
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
                            _currentPatientId = value as String;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 25),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(),
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
                  const Text(
                    "Please answer the following questions",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text('Is the patient alert?'),
                      value: _patientAlert,
                      onChanged: (bool value) {
                        setState(() {
                          _patientAlert = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text(
                          'Does the patient have any trouble breathing?'),
                      value: _troubleBreathing,
                      onChanged: (bool value) {
                        setState(() {
                          _troubleBreathing = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text(
                          'Does the patient have any trouble swallowing?'),
                      value: _troubleSwallowing,
                      onChanged: (bool value) {
                        setState(() {
                          _troubleSwallowing = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text(
                          'Does the patient have any tightness in their throat or chest?'),
                      value: _tightnessThroatOrChest,
                      onChanged: (bool value) {
                        setState(() {
                          _tightnessThroatOrChest = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text(
                          'Is the patient feeling dizzy, faint or sweaty?'),
                      value: _dizzyFaintOrSweaty,
                      onChanged: (bool value) {
                        setState(() {
                          _dizzyFaintOrSweaty = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text('Is the patient pale?'),
                      value: _pale,
                      onChanged: (bool value) {
                        setState(() {
                          _pale = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    child: SwitchListTile(
                      title: const Text(
                          'Does the patient have any history of allergic reactions?'),
                      value: _historyAllergicReactions,
                      onChanged: (bool value) {
                        setState(() {
                          _historyAllergicReactions = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey, width: 1)),
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
        ),
      ),
    );
  }
}
