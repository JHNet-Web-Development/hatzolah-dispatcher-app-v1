import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyConfig.dart';

class NatureOfEmergencyScreen extends StatefulWidget {
  const NatureOfEmergencyScreen({Key? key}) : super(key: key);

  @override
  State<NatureOfEmergencyScreen> createState() =>
      _NatureOfEmergencyScreenState();
}

class _NatureOfEmergencyScreenState extends State<NatureOfEmergencyScreen> {
  final CallsCubit _callsCubit = sl<CallsCubit>();

  @override
  void initState() {
    _callsCubit.getNatureEmergencyConfigs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      bloc:  _callsCubit,
      builder: (context, state) {
        return Scaffold(
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: state.mainCallsState.configs.length,
              itemBuilder: (BuildContext ctx, index) {
                NatureEmergencyConfig config =  state.mainCallsState.configs[index];
                return Container(
                  alignment: Alignment.center,
                  child: Text(config.name??""),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                );
              }),
        );
      },
    );
  }
}
