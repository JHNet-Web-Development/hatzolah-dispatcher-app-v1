import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/hospital/hospital_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';


class HospitalEditScreen extends StatefulWidget {
  final Hospital hospital;
  const HospitalEditScreen({Key? key, required this.hospital}) : super(key: key);

  @override
  State<HospitalEditScreen> createState() => _HospitalEditScreenState();
}

class _HospitalEditScreenState extends State<HospitalEditScreen> {
  // cubits
  final HospitalCubit _hospitalsCubit = sl<HospitalCubit>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _saveInfo(Hospital hospital) {
    FocusScope.of(context).unfocus();
    _hospitalsCubit.createUpdateHospital(hospital.copyWith(name: nameController.text.trim(), updatedDate: Timestamp.now()));
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.hospital.name;
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<HospitalCubit, HospitalState>(
      bloc: _hospitalsCubit,
      listener: (context, state) {
        if(state is HospitalUpdated){
          const snackBar = SnackBar(
            content: Text('Yay! Hospital completed!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) => Navigator.pop(context));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.hospital.name),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Text(widget.hospital.name),
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
                          labelText: "Name",
                          hintText: "Netcare Sunninghill Hospital",
                        ),
                        keyboardType: TextInputType.number,
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Name is empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _formKey.currentState!.validate() ? _saveInfo(widget.hospital) : null,
                        child: const Text("Update"),
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
