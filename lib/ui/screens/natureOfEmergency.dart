import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyConfig.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/abdominalPainScreen.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/bitesAndStingsScreen.dart';

class NatureOfEmergencyScreen extends StatefulWidget {
  const NatureOfEmergencyScreen({Key? key}) : super(key: key);

  @override
  State<NatureOfEmergencyScreen> createState() =>
      _NatureOfEmergencyScreenState();
}

class _NatureOfEmergencyScreenState extends State<NatureOfEmergencyScreen> {
  final CallsCubit _callsCubit = sl<CallsCubit>();

  _openNatureOfEmergencyQuestions(int id)
  {
    switch (id) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AbdominalPainScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BiteAndStingsScreen()),
        );
        break;
    }
  }

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
          appBar: AppBar(
            title: const Text("Choose the nature of Emergency"),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: state.mainCallsState.configs.length,
                itemBuilder: (BuildContext ctx, index) {
                  NatureEmergencyConfig config =  state.mainCallsState.configs[index];
                  return GestureDetector(
                    onTap: () => _openNatureOfEmergencyQuestions(config.id!),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(config.name??"", style: const TextStyle(color: Colors.white, fontSize: 16),),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Icon(Icons.bloodtype, color: Colors.white,),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: primaryColour,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
