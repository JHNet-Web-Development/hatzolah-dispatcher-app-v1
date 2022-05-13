import 'dart:async';

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
import 'package:hatzolah_dispatcher_app/ui/widgets/home/callCard.dart';
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
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            child: BlocBuilder<CallsCubit, CallsState>(
              bloc: _callsCubit,
              builder: (context, state) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.mainCallsState.calls.length,
                    itemBuilder: (context, index) {
                      Call call = state.mainCallsState.calls[index];
                      return CallCard(call: call);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
