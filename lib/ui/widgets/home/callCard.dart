import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/call-status-list.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/abdominalPainScreen.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/call-of-nature-questions/bitesAndStingsScreen.dart';
import 'package:intl/intl.dart';

class CallCard extends StatefulWidget {
  final Call call;

  const CallCard({Key? key, required this.call}) : super(key: key);

  @override
  State<CallCard> createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
  int _passedDispatchedDuration = 1;
  Timer? _timer;

  @override
  void initState() {
    if(widget.call.status != CallStatusList.closed.index){
      _passedDispatchedDuration = DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(widget.call.dispatchedDate.microsecondsSinceEpoch)).inMicroseconds;
      const oneSec = Duration(seconds:1);
      _timer = Timer.periodic(oneSec, (Timer t) {
        _passedDispatchedDuration = _passedDispatchedDuration + 1000000;
        setState(() {

        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: _getStatusColour(widget.call.status), width: 1.5)
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: widget.call.patient.firstName + " " + widget.call.patient.lastName,
                  style: TextStyle(color: _getStatusColour(widget.call.status), fontSize: 15, fontWeight: FontWeight.w500),
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
                              text: 'Active Time: ',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            TextSpan(
                              text: widget.call.status == CallStatusList.closed.index ? _formatDuration(DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(widget.call.dispatchedDate.microsecondsSinceEpoch)).inMicroseconds) : _formatDuration(_passedDispatchedDuration),
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
                              text: 'Nature of Emergency: ',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            TextSpan(
                              text: _getNatureOfEmergencyText(widget.call.questionType),
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
              const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 10),
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
              subtitle: Column(children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: 'Address: ',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.call.address,
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
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
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
                                  text: DateFormat('dd/MM/yyyy, hh:mm a').format(widget.call.dispatchedDate.toDate()),
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
                                  text: 'Accepted Date: ',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.call.acceptedDate == null ? null : DateFormat('dd/MM/yyyy, hh:mm a').format(widget.call.acceptedDate!.toDate()),
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
                                  text: 'Arrived Date: ',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.call.arrivedDate == null ? null : DateFormat('dd/MM/yyyy, hh:mm a').format(widget.call.arrivedDate!.toDate()),
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
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: 'Closed Date: ',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.call.closedDate == null ? null : DateFormat('dd/MM/yyyy, hh:mm a').format(widget.call.closedDate!.toDate()),
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
                  padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: warningColour,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: warningColour),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                            Text(
                              "Edit ",
                              style: TextStyle(color: Colors.white),
                            )
                        ],
                      ),
                      onPressed: () {
                        _editCall(widget.call);
                      },
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
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
        return "Vitals Loaded";
      case 4:
        return "Closed";
    }
  }

  _getStatusColour(int status) {
    switch (status) {
      case 0:
        return dangerColour;
      case 1:
        return warningColour;
      case 2:
        return primaryColour;
      case 3:
        return greyColour;
      case 4:
        return successColour;
    }
  }

  _getNatureOfEmergencyText(int natureOfEmergency) {
    switch (natureOfEmergency) {
      case 0:
        return "Abdominal Pain";
      case 1:
        return "Bites and Stings";
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
}
