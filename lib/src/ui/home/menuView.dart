import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/animationSwitch_bloc/animationSwitch_bloc.dart';
import '../../bloc/animationSwitch_bloc/animationSwitch_event.dart';
import '../../bloc/animationSwitch_bloc/animationSwitch_state.dart';
import '../uiScreen/themas.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late AnimationSwitchBloc _animationSwitchBloc;

  @override
  void didChangeDependencies() {
    _animationSwitchBloc = BlocProvider.of<AnimationSwitchBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color.fromARGB(130, 37, 31, 52),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Primer boton
            GestureDetector(
              onTap: () {
                _animationSwitchBloc.add(reportarPage());
              },
              child: BlocBuilder<AnimationSwitchBloc, AnimationSwitchState>(
                builder: (context, state) {
                  if (state.isHome) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        color: Color.fromARGB(48, 28, 36, 63),
                      ),
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              IconData(0xe52a, fontFamily: 'MaterialIcons'),
                              color: Color(0xff14DAE2),
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Inicio',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff14DAE2)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        const Icon(
                          IconData(0xe52a, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel:
                          'Text to announce in accessibility modes',
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Inicio',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );

                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            //segundo boton
            GestureDetector(
              onTap: () {
                _animationSwitchBloc.add(BuscarChat());
              },
              child: BlocBuilder<AnimationSwitchBloc, AnimationSwitchState>(
                builder: (context, state) {

                  if (state.isFindMap) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        color: Color.fromARGB(48, 28, 36, 63),
                      ),
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              IconData(0xed3d, fontFamily: 'MaterialIcons'),
                              color: Color(0xff14DAE2),
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Mis incidencias',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff14DAE2)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            IconData(0xed3d, fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                            'Text to announce in accessibility modes',
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Mis incidencias',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //tercer boton
            GestureDetector(
              onTap: () {
                _animationSwitchBloc.add(BuscarPerfil());
              },
              child: BlocBuilder<AnimationSwitchBloc, AnimationSwitchState>(
                builder: (context, state) {
                  if (state.isPerfil) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        color: Color.fromARGB(48, 28, 36, 63),
                      ),
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              IconData(0xe743, fontFamily: 'MaterialIcons'),
                              color: Color(0xff14DAE2),
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Perfil',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff14DAE2)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(
                            IconData(0xe743, fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel:
                            'Text to announce in accessibility modes',
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Perfil',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
