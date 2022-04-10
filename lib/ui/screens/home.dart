import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/hospital/hospital_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/hospitalCreateEdit.dart';
import 'package:hatzolah_dispatcher_app/ui/widgets/home/callWidget.dart';
import 'package:hatzolah_dispatcher_app/ui/widgets/home/hospitalGridWidget.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // Constant values
  final String _welcomeMessage = "Welcome to Hatzolah.";

  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();
  final CallsCubit _callsCubit = sl<CallsCubit>();
  final HospitalCubit _hospitalCubit = sl<HospitalCubit>();
  late TabController tabController;

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

  _createHospitals() {

    List<Hospital> hospitals = [
      Hospital(id: const Uuid().v4(), name: "Netcare Sunward Park Hospital", createdDate: Timestamp.now()),
      Hospital(id: const Uuid().v4(), name: "Netcare Sunninghill Hospital", createdDate: Timestamp.now()),
    ];

    for (var i = 0; i < hospitals.length; i++) {
      _hospitalCubit.createUpdateHospital(hospitals[i]);
    }
  }

  @override
  void initState() {
    super.initState();
   tabController = TabController(length: 2, vsync: this);
    _callsCubit.getNewCalls();
    _callsCubit.getUserCalls();
    _hospitalCubit.getHospitals();
    //_createCalls();
   // _createHospitals();
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

  _createHospital() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HospitalCreateEditScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColour,
          bottom:  TabBar(
              controller: tabController,
              tabs: const [
            Tab(
                text: "Calls",
                icon: Icon(Icons.local_hospital)
            ),
            Tab(
                text: "Hospitals",
                icon: Icon(Icons.apartment)
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
          child:  TabBarView(
            controller: tabController,
              children: const [
            CallWidget(myList: false,),
            HospitalGridWidget(),
          ])
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),

          onPressed: () => tabController.index == 0 ?  null :  _createHospital(),
          backgroundColor: successColour,
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
