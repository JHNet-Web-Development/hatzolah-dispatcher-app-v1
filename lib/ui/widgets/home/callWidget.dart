import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
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

  _confirmCallAssignment(Call call) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Accept Call'),
          content: const Text('Are you sure you want to accept this call?'),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: dangerColour,
                ),
                onPressed: () => Navigator.pop(context), child: const Text('No')
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: successColour,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _callsCubit.createUpdateCall(call.copyWith(userId: "LnOoUagCqSeFimMXgAcDZdwXMnB3"));
                },
                child: const Text('Yes')),
          ],
        );
      }
    );
  }

  _editCall(Call call) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CallEditScreen(call: call)),
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
                      onTap: () => !widget.myList ? _confirmCallAssignment(call) : _editCall(call),
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
