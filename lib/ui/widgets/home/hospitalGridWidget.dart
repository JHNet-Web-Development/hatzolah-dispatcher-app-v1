import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/hospital/hospital_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';
import 'package:intl/intl.dart';

class HospitalGridWidget extends StatefulWidget {
  const HospitalGridWidget({Key? key}) : super(key: key);

  @override
  State<HospitalGridWidget> createState() => _HospitalGridWidgetState();
}

class _HospitalGridWidgetState extends State<HospitalGridWidget> {
  final HospitalCubit _hospitalCubit = sl<HospitalCubit>();

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
                      onTap: () => null,
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.apartment, size: 40, color: primaryColour),
                          title: Text(hospital.name),
                          subtitle: Text(DateFormat('dd/MM/yyyy, hh:mm a').format(hospital.createdDate.toDate())),
                          isThreeLine: true,
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
