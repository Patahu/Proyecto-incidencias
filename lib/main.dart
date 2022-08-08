import 'package:aplicacionincidentes/src/bloc/aunthentication_bloc/simple_bloc_delegate.dart';
import 'package:aplicacionincidentes/src/bloc/messaging_bloc/messaging_bloc.dart';
import 'package:aplicacionincidentes/src/ui/home/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/aunthentication_bloc/bloc.dart';

import 'src/bloc/homeReportIncident_bloc/bloc.dart';
import 'src/bloc/animationSwitch_bloc/bloc.dart';
import 'src/bloc/incident_bloc/bloc.dart';
import 'src/bloc/messaging_bloc/bloc.dart';
import 'src/bloc/perfilView_bloc/bloc.dart';
import 'src/bloc/perfilView_bloc/perfilView_event.dart';
import 'src/repository/data_base_firestores.dart';
import 'src/repository/data_base_incidents.dart';
import 'src/repository/firebase_messaging.dart';
import 'src/repository/user_repository.dart';
import 'src/ui/login/login_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Se recivio una notificación --------------------");
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  final DataBaseIncident databaseIncidentes = DataBaseIncident(userRepository: userRepository);
  final FirebaseMessagingD firebaseMessaging = FirebaseMessagingD();
  final DataBaseIncidentFirestore dataBaseIncidentFirestore =
      DataBaseIncidentFirestore();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(userRepository: userRepository),
      ),
      BlocProvider<AnimationSwitchBloc>(
        create: (BuildContext context) => AnimationSwitchBloc(),
      ),
      BlocProvider<MessagingBloc>(
        create: (BuildContext context) =>
            MessagingBloc(firebaseMessaging: firebaseMessaging,dataBaseIncident: databaseIncidentes,)..add(startMessagingListener()),
      ),
      BlocProvider<IncidenciasBloc>(
        create: (BuildContext context) =>
            IncidenciasBloc(dataBaseIncident: databaseIncidentes),
      ),
      BlocProvider<reportIncidentBloc>(
        create: (context) => reportIncidentBloc(
          dataBaseIncident: databaseIncidentes,
          dataBaseIncidentFirestore: dataBaseIncidentFirestore,
        ),
      ),
      BlocProvider<perfilViewBloc>(
        create: (context) => perfilViewBloc(
  userRepository: userRepository,
        ),
      ),
    ],
    child: App(
      userRepository: userRepository,
      databaseIncidentes: databaseIncidentes,
      dataBaseIncidentFirestore: dataBaseIncidentFirestore,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final DataBaseIncident _databaseIncidentes;
  final DataBaseIncidentFirestore _dataBaseIncidentFirestore;
  App(
      {Key? key,
      required UserRepository userRepository,
      required DataBaseIncident databaseIncidentes,
      required DataBaseIncidentFirestore dataBaseIncidentFirestore})
      : _userRepository = userRepository,
        _databaseIncidentes = databaseIncidentes,
        _dataBaseIncidentFirestore = dataBaseIncidentFirestore,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
            return Container(
              color: Colors.black,
            );
          }
          if (state is Authenticated) {
            BlocProvider.of<IncidenciasBloc>(context)
                .add(BuscarIncidentesEvent(state.user!.uid));

            BlocProvider.of<perfilViewBloc>(context)
                .add(iniciarUsuarioVerificar(state.user!));

            BlocProvider.of<MessagingBloc>(context)
                .add(startFirebaseListener(state.user!.uid));
            return HomeScreen(
              user: state.user,
              databaseIncidentes: _databaseIncidentes,
              dataBaseIncidentFirestore: _dataBaseIncidentFirestore,
            );
          }
          if (state is unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return Container(  color: Colors.black,);
        },
      ),
    );
  }
}
