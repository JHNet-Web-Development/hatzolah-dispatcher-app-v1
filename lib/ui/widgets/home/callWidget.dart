import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/abdominalPainScreen.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/bitesAndStingsScreen.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/callEdit.dart';
import 'package:intl/intl.dart';

class CallWidget extends StatefulWidget {
  final bool myList;
  const CallWidget({Key? key, required this.myList}) : super(key: key);

  @override
  State<CallWidget> createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  final CallsCubit _callsCubit = sl<CallsCubit>();

  _editCall(Call call) {
    dynamic screenType;

    switch (call.questionType) {
      case 0:
        screenType = AbdominalPainScreen(call: call);
        break;
      case 1:
        screenType = BiteAndStingsScreen(call: call);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<CallsCubit, CallsState>(
            bloc: _callsCubit,
            builder: (context, state) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.myList ? state.mainCallsState.userCalls.length : state.mainCallsState.newCalls.length,
                  itemBuilder: (context, index) {
                    Call call = widget.myList ? state.mainCallsState.userCalls[index] : state.mainCallsState.newCalls[index];
                    return GestureDetector(
                      onTap: () => _editCall(call),
                      child: Card(
                        child: ListTile(
                          leading: widget.myList ? Icon(Icons.medical_services, size: 40, color: successColour) : Icon(Icons.error, size: 40, color: dangerColour),
                          title: Text(call.patient.firstName + " " + call.patient.lastName),
                          subtitle: Text(DateFormat('dd/MM/yyyy, hh:mm a').format(call.dispatchedDate.toDate())),
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
