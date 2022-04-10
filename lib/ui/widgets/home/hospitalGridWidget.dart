import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/hospital/hospital_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/hospitalEdit.dart';
import 'package:intl/intl.dart';

class HospitalGridWidget extends StatefulWidget {
  const HospitalGridWidget({Key? key}) : super(key: key);

  @override
  State<HospitalGridWidget> createState() => _HospitalGridWidgetState();
}

class _HospitalGridWidgetState extends State<HospitalGridWidget> {
  final HospitalCubit _hospitalCubit = sl<HospitalCubit>();

  _editHospital(Hospital hospital) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HospitalEditScreen(hospital: hospital)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<HospitalCubit, HospitalState>(
            bloc: _hospitalCubit,
            builder: (context, state) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.mainHospitalState.hospitals.length,
                  itemBuilder: (context, index) {
                    Hospital hospital = state.mainHospitalState.hospitals[index];
                    return GestureDetector(
                      onTap: () => _editHospital(hospital),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.apartment, size: 40, color: primaryColour),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Name: ', style: TextStyle(color: Colors.grey, fontSize: 12),),
                                    TextSpan(text: hospital.name, style: TextStyle(color: Colors.black, fontSize: 14),)
                                  ]
                              ),
                            ),
                          ),
                          subtitle: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: 'Created Date: ', style: TextStyle(color: Colors.grey, fontSize: 12),),
                                  TextSpan(text: DateFormat('dd/MM/yyyy, hh:mm a').format(hospital.createdDate.toDate()), style: TextStyle(color: Colors.black, fontSize: 14),)
                                ]
                            ),
                          ),
                          isThreeLine: false,
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
