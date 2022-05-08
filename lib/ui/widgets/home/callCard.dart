import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/call-status-list.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:intl/intl.dart';

class CallCard extends StatefulWidget {
  final Call call;

  const CallCard({Key? key, required this.call}) : super(key: key);

  @override
  State<CallCard> createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
  int _passedDispatchedDuration = 1;

  @override
  void initState() {
    _passedDispatchedDuration = DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(widget.call.dispatchedDate.microsecondsSinceEpoch)).inMicroseconds;
    const oneSec = Duration(seconds:1);
    Timer.periodic(oneSec, (Timer t) {
      _passedDispatchedDuration = _passedDispatchedDuration + 1000000;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(Icons.medical_services, size: 40, color: successColour),
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
                text: widget.call.patient.firstName + " " + widget.call.patient.lastName,
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
                                .format(widget.call.dispatchedDate.toDate()),
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
                            text: _formatDuration(_passedDispatchedDuration),
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
                            text: _getStatusText(widget.call.status),
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
              widget.call.address,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
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

  String _formatDuration(int time) {
    Duration duration = Duration(microseconds: time);

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
