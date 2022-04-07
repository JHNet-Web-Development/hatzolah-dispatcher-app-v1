import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/ui/widgets/home/callWidget.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Constant values
  final String _welcomeMessage = "Welcome to Hatzolah.";

  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();
  final CallsCubit _callsCubit = sl<CallsCubit>();

  //Remove this
  _createCalls() {

      List<Call> calls = [
        Call(id: const Uuid().v4(), patientId: "1o4Ne6GsML51CAUuqEmp", patient: Patient(id: "1o4Ne6GsML51CAUuqEmp", firstName: "John", lastName: "Doe", createdDate: Timestamp.now()), userId: null, createdDate: Timestamp.now()),
        Call(id: const Uuid().v4(), patientId: "U3uJVU42gimKUe1Gu1j6", patient: Patient(id: "U3uJVU42gimKUe1Gu1j6", firstName: "Gary", lastName: "Musk", createdDate: Timestamp.now()), userId: null, createdDate: Timestamp.now()),
        Call(id: const Uuid().v4(), patientId: "gK7pePxUQBveiu22BaZT", patient: Patient(id: "gK7pePxUQBveiu22BaZT", firstName: "Mary", lastName: "Woodland", createdDate: Timestamp.now()), userId: null, createdDate: Timestamp.now())
      ];

      for (var i = 0; i < calls.length; i++) {
        _callsCubit.createUpdateCall(calls[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    _callsCubit.getNewCalls();
    _callsCubit.getUserCalls();
    //_createCalls();
  }

  _confirmLogout() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to Logout?'),
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
                    _authenticationCubit.loggedOut(clearPreferences: true);
                  },
                  child: const Text('Yes')),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColour,
          bottom: const TabBar(tabs: [
            Tab(
                text: "New Calls",
                icon: Icon(Icons.local_hospital)
            ),
            Tab(
                text: "My Calls",
                icon: Icon(Icons.list)
            ),
          ]),
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: () =>
                    _confirmLogout(),
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const TabBarView(children: [
            CallWidget(myList: false,),
            CallWidget(myList: true,)
          ])
        ),
      ),
    );
  }
}