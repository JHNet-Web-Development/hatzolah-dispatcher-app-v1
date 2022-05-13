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
import 'package:hatzolah_dispatcher_app/ui/screens/natureOfEmergency.dart';
import 'package:hatzolah_dispatcher_app/ui/widgets/home/callWidget.dart';
import 'package:hatzolah_dispatcher_app/ui/widgets/home/hospitalGridWidget.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();
  final CallsCubit _callsCubit = sl<CallsCubit>();
  final HospitalCubit _hospitalCubit = sl<HospitalCubit>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
   tabController = TabController(length: 2, vsync: this);
    _callsCubit.getCalls();
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

  _createCall() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NatureOfEmergencyScreen()),
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

          onPressed: () => tabController.index == 0 ?  _createCall() :  _createHospital(),
          backgroundColor: primaryColour,
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
