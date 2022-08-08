import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../bloc/homeReportIncident_bloc/bloc.dart';
import '../../bloc/login_bloc/bloc.dart';
import '../../repository/data_base_firestores.dart';
import '../../repository/data_base_incidents.dart';
import '../../repository/user_repository.dart';
import '../../util/authUser.dart';
import 'homeReportView.dart';

class homeScreenView extends StatelessWidget {
  final AuthUser? _user;
  final DataBaseIncident _databaseIncidentes;
  final DataBaseIncidentFirestore _dataBaseIncidentFirestore;
  homeScreenView(
      {Key? key,
      AuthUser? user,
      required DataBaseIncident databaseIncidentes,
      required DataBaseIncidentFirestore dataBaseIncidentFirestore})
      : _user = user,
        _databaseIncidentes = databaseIncidentes,
        _dataBaseIncidentFirestore = dataBaseIncidentFirestore,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        BlocProvider.of<reportIncidentBloc>(context).add(inicialR());
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff251F34),
            ),
            MainPageState(user: _user!),
          ],
        ),
      ),
    );
  }
}
