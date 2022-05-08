import 'package:cloud_firestore/cloud_firestore.dart';
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
                  itemCount: widget.myList
                      ? state.mainCallsState.userCalls.length
                      : state.mainCallsState.newCalls.length,
                  itemBuilder: (context, index) {
                    Call call = widget.myList
                        ? state.mainCallsState.userCalls[index]
                        : state.mainCallsState.newCalls[index];
                    return _callCard(call);
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget _callCard(Call call) {
    return Card(
      child: ExpansionTile(
        leading: widget.myList
            ? Icon(Icons.medical_services, size: 40, color: successColour)
            : Icon(Icons.error, size: 40, color: dangerColour),
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 10),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: <TextSpan>[
              const TextSpan(
                text: 'Patient: ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextSpan(
                text: call.patient.firstName + " " + call.patient.lastName,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              )
            ]),
          ),
        ),
        subtitle: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                        text: 'Dispatched Date: ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      TextSpan(
                        text: DateFormat('dd/MM/yyyy, hh:mm a')
                            .format(call.dispatchedDate.toDate()),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      )
                    ]),
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                        text: 'Active Time: ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      TextSpan(
                        text: _getActiveTimeText(call),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      )
                    ]),
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                        text: 'Status: ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      TextSpan(
                        text: _getStatusText(call.status),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      )
                    ]),
                  )),
                ),
              ],
            ),
          ),
        ]),
        children: <Widget>[
          ListTile(
            title: Text(
              call.address,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

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

  _getActiveTimeText(Call call) {
    /*DateTime dispatchedTime = DateTime.parse(call.dispatchedDate.toString());
    DateTime currentTime = DateTime.now();
    String difference = currentTime.difference(dispatchedTime).toString();*/
    return "00h 05m 59s";
  }

  _getStatusText(int status) {
    switch (status) {
      case 0:
        return "Dispatched";
      case 1:
        return "Accepted";
      case 2:
        return "Arrived";
      case 3:
        return "Closed";
    }
  }
}
