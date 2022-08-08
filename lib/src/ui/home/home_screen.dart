import 'package:aplicacionincidentes/src/bloc/perfilView_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

import '../../bloc/aunthentication_bloc/authentication_bloc.dart';
import '../../bloc/aunthentication_bloc/authentication_event.dart';

import '../../bloc/animationSwitch_bloc/animationSwitch_bloc.dart';

import '../../bloc/animationSwitch_bloc/animationSwitch_state.dart';
import '../../bloc/incident_bloc/bloc.dart';
import '../../bloc/messaging_bloc/bloc.dart';

import '../../repository/data_base_firestores.dart';
import '../../repository/data_base_incidents.dart';
import '../../util/authUser.dart';
import '../uiScreen/screenIncident.dart';
import '../uiScreen/themas.dart';
import 'homePrincipalScreenView.dart';

import 'menuView.dart';
import 'perfilView.dart';

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  final AuthUser? _user;

  final DataBaseIncident _databaseIncidentes;
  final DataBaseIncidentFirestore _dataBaseIncidentFirestore;
  HomeScreen(
      {Key? key,
      AuthUser? user,
      required DataBaseIncident databaseIncidentes,
      required DataBaseIncidentFirestore dataBaseIncidentFirestore})
      : _user = user,
        _databaseIncidentes = databaseIncidentes,
        _dataBaseIncidentFirestore = dataBaseIncidentFirestore,
        super(key: key) {}
  Color _elejirColor(String tipo) {
    if (tipo == 'Pendiente') {
      return Colors.orange;
    } else if (tipo == 'En camino') {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<perfilViewBloc,perfilViewtState>(
        listener:(context,state){
          if(state.isRequiredReload){
            ScaffoldMessenger.of(context)
            // ignore: deprecated_member_use
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Cambio realizado'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
          }
        },
        builder:(context,state){
          return SimpleHiddenDrawer(
            slidePercent: 50.0,
            verticalScalePercent: 100.0,
            contentCornerRadius: 3.0,
            menu: Menu(),
            screenSelectedBuilder: (position, controller) {
              return Scaffold(
                backgroundColor: Color(0xfff3B324E),
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 24, 40, 72),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(72.0),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.logout),
                          color: Color(0xff14dae2),
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoggedOut());
                          }),
                    ],
                  ),
                  leading: Center(
                    child: IconButton(
                        icon: Icon(Icons.menu),
                        color: Color(0xff14DAE2),
                        onPressed: () {
                          controller.toggle();
                        }),
                  ),
                ),
                body: BlocBuilder<AnimationSwitchBloc, AnimationSwitchState>(
                  builder: (context, state) {
                    if (state.isHome) {
                      return homeScreenView(
                        user: _user,
                        databaseIncidentes: _databaseIncidentes,
                        dataBaseIncidentFirestore: _dataBaseIncidentFirestore,
                      );
                    }
                    if (state.isFindMap) {
                      return Center(
                        child: BlocBuilder<IncidenciasBloc, IncidentViewState>(
                          builder: (context, state) {
                            if (state.isNewMessaging) {
                              return GridView(
                                padding: const EdgeInsets.all(8),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                children: List<Widget>.generate(
                                  state.mensajes!.length,
                                      (int index) {
                                    final incindente = state.mensajes![index];
                                    return InkWell(

                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:

                                          const BorderRadius.all(
                                              Radius.circular(
                                                  16.0)),
                                          // border: new Border.all(
                                          //     color: DesignCourseAppTheme.notWhite),
                                        ),
                                        child: Stack(
                                          alignment:
                                          AlignmentDirectional.bottomCenter,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Container(

                                                      decoration: BoxDecoration(
                                                        color: _elejirColor('${incindente.estado}').withOpacity(0.2),
                                                        borderRadius:

                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16.0)),
                                                        // border: new Border.all(
                                                        //     color: DesignCourseAppTheme.notWhite),
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 16,
                                                                        left:
                                                                        16,
                                                                        right:
                                                                        16),
                                                                    child: Text(
                                                                      '${incindente.tipo}',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                        fontSize:
                                                                        16,
                                                                        letterSpacing:
                                                                        0.27,
                                                                        color: DesignCourseAppTheme
                                                                            .darkerText,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 8,
                                                                        left:
                                                                        16,
                                                                        right:
                                                                        16,
                                                                        bottom:
                                                                        8),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          '${incindente.fecha!.toDate().year}/' +
                                                                              '${incindente.fecha!.toDate().month}/' +
                                                                              '${incindente.fecha!.toDate().day}',
                                                                          textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                          style:
                                                                          TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w400,
                                                                            fontSize:
                                                                            14,
                                                                            letterSpacing:
                                                                            0.27,
                                                                            color: Colors
                                                                                .black,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                          Row(
                                                                            children: <
                                                                                Widget>[
                                                                              Text(
                                                                                'Estado:',
                                                                                textAlign:
                                                                                TextAlign.left,
                                                                                style:
                                                                                TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 12,
                                                                                  letterSpacing: 0.27,
                                                                                  color: Colors.grey[600],
                                                                                ),
                                                                              ),     Text(
                                                                                '${incindente.estado}',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 12,
                                                                                  letterSpacing: 0.27,
                                                                                  color: _elejirColor('${incindente.estado}'),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Fotos: 5/${incindente.fotos!.length}',
                                                                          style:
                                                                          TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w500,
                                                                            fontSize:
                                                                            12,
                                                                            letterSpacing:
                                                                            0.27,
                                                                            color: Colors
                                                                                .grey[600],
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Video: 1/${incindente.video == null ? 0 : 1}',
                                                                          style:
                                                                          TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w500,
                                                                            fontSize:
                                                                            12,
                                                                            letterSpacing:
                                                                            0.27,
                                                                            color: Colors
                                                                                .grey[600],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 40,
                                                    right: 25,
                                                    left: 25,
                                                    bottom: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16.0)),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: DesignCourseAppTheme
                                                            .grey
                                                            .withOpacity(0.2),
                                                        offset:
                                                        const Offset(0.0, 0.0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                      child: AspectRatio(
                                                        aspectRatio: 1.28,
                                                        child: Image.asset(
                                                            'assets/${incindente.tipo}.png'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 32.0,
                                  crossAxisSpacing: 32.0,
                                  childAspectRatio: 0.8,
                                ),
                              );
                            }

                            return Container();
                          },
                        ),
                      );
                    }
                    if (state.isPerfil) {
                      return PerfilW(
                        usuario: _user!,
                      );
                    }

                    return Container();
                  },
                ),
              );
            },
          );
        }
      ),
    );
  }
}
