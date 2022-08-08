
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';


import '../../bloc/homeReportIncident_bloc/bloc.dart';
import '../../bloc/perfilView_bloc/bloc.dart';
import '../../bloc/perfilView_bloc/perfilView_event.dart';
import '../../util/authUser.dart';
import '../uiScreen/themas.dart';
import 'phones_screen.dart';

class MainPageState extends StatefulWidget {
  final AuthUser _user;
  MainPageState({
    Key? key,
    required AuthUser user,
  })  : _user = user,
        super(key: key);

  @override
  _homeMainPageState createState() => _homeMainPageState();
}

class _homeMainPageState extends State<MainPageState> {
  TextEditingController _descripcion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  reportIncidentBloc? _reporIncidentBloc;
  perfilViewBloc? _perfilViewBloc;

  AuthUser get _user => widget._user;
  bool _requiredOther=false;
  @override
  void initState() {
    super.initState();

    _descripcion.addListener(_onDescripcionChanged);
    _telefono.addListener(_onTelefonoChanged);
    _dni.addListener(_onDNIChanged);
    _perfilViewBloc=BlocProvider.of<perfilViewBloc>(context);
    _reporIncidentBloc = BlocProvider.of<reportIncidentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<reportIncidentBloc, homeReportIncidentState>(
        listener: (context, state) {
          if(_requiredOther && state.isNormal){
            BlocProvider.of<perfilViewBloc>(context)
                .add(chaDatasUsuarioDB());
          }
      if (state.isSuccess) {

        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Ingreso Completado'),
                  Icon(IconData(0xe05b, fontFamily: 'MaterialIcons'))
                ],
              ),
              backgroundColor: Colors.green,
            ),
          );

      } else if (state.isFail) {
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Ingreso fallido'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }  else if (state.isError) {
        ScaffoldMessenger.of(context)
        // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Error',style: TextStyle(color: Colors.black)), Icon(Icons.error)],
              ),
              backgroundColor: Colors.yellow,
            ),
          );
      } else if (state.isLoading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Cargando... '),
                CircularProgressIndicator(),
              ],
            ),
          ));
      } else if (state.isUploadPhoto) {
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Archivo subido'),
                  Icon(IconData(0xe795, fontFamily: 'MaterialIcons'))
                ],
              ),
              backgroundColor: Colors.green,
            ),
          );
      }
    }, builder: (context, state) {
      if (state.isNormal) {
        return Center(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<reportIncidentBloc>(context)
                                  .add(enterTipo('Emergencia', _user));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 5, left: 5),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.23,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.23,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 212, 103, 88)
                                                      .withOpacity(0.5),
                                                  offset: const Offset(
                                                      0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          16.0)),
                                              child: AspectRatio(
                                                aspectRatio: 1.28,
                                                child: Image.asset(
                                                    'assets/Emergencia.png'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Emergencia",
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<reportIncidentBloc>(
                                          context)
                                      .add(enterTipo('Robo', _user));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width *
                                      0.3,
                                  height:
                                      MediaQuery.of(context).size.width *
                                          0.3,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 5, left: 5),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.23,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.23,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 37, 64, 114)
                                                      .withOpacity(0.5),
                                                  offset: const Offset(
                                                      0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          16.0)),
                                              child: AspectRatio(
                                                aspectRatio: 1.28,
                                                child: Image.asset(
                                                    'assets/Robo.png'),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            "Robo",
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context)
                      .size
                      .width *
                      0.1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<reportIncidentBloc>(context)
                                  .add(enterTipo('Incendio', _user));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white.withOpacity(1),
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.23,
                                        height: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.23,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(16.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: DesignCourseAppTheme
                                                  .grey
                                                  .withOpacity(0.5),
                                              offset:
                                                  const Offset(0.0, 0.0),
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16.0)),
                                            child: AspectRatio(
                                              aspectRatio: 1.28,
                                              child: Image.asset(
                                                  'assets/Incendio.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Incendio",
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<reportIncidentBloc>(context)
                                  .add(enterTipo('Denuncia', _user));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.23,
                                        height: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.23,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(16.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: DesignCourseAppTheme
                                                  .grey
                                                  .withOpacity(0.5),
                                              offset:
                                                  const Offset(0.0, 0.0),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(16.0)),
                                          child: AspectRatio(
                                            aspectRatio: 1.28,
                                            child: Image.asset(
                                                'assets/Denuncia.png'),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Denuncia",
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context)
                  .size
                  .width *
                  0.1,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<reportIncidentBloc>(context)
                                  .add(iniciarTelefonos());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0),
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.blue,
                                          onPressed: () {},
                                          heroTag: 'image2',
                                          tooltip: 'Take a Photo',
                                          child: const Icon(IconData(0xf187,
                                              fontFamily: 'MaterialIcons')),
                                        ),
                                      ),
                                      const Text(
                                        "Teléfonos",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff14DAE2)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<reportIncidentBloc>(context)
                                  .add(inicialWhatssapp());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0),
                                        child: FloatingActionButton(
                                          backgroundColor: Color.fromRGBO(
                                              79, 206, 93, 1),
                                          onPressed: () {},
                                          heroTag: 'image2',
                                          tooltip: 'Take a Photo',
                                          child: const Icon(IconData(
                                              0xf05a6,
                                              fontFamily: 'MaterialIcons')),
                                        ),
                                      ),
                                      const Text(
                                        "Whatsapp",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff14DAE2)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (state.isEnter) {
        return Container(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: ListView(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                children: [
                  const Text('Tipo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff14DAE2))),
                  const SizedBox(height: 8),
                  Text(state.incindente.tipo!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Descripción',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff14DAE2))),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    controller: _descripcion,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingrese un comentario',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8),

                  BlocBuilder<reportIncidentBloc, homeReportIncidentState>(

                    builder: (context, state) {
                      return Column(
                          children: [
                            BlocBuilder<perfilViewBloc,perfilViewtState>(
                            builder: (context, state) {
                              if(_user.numero=='' || _user.dni==''){
                                _requiredOther=true;
                                return Column(
                                  children: [
                                    TextFormField(
                                      controller: _dni,
                                      maxLength: 8,
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          icon: Icon(IconData(0xe619, fontFamily: 'MaterialIcons'),color: Color(0xff14DAE2)),
                                          labelText: 'DNI',
                                          labelStyle: TextStyle(color: Colors.white)),
                                      validator: (_) {
                                        return state.isDNIRequired ? 'Requiere este campo' : null;
                                      },
                                      autocorrect: false,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                    TextFormField(
                                      controller: _telefono,
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          icon: Icon(IconData(0xe4a3, fontFamily: 'MaterialIcons'),color: Color(0xff14DAE2)),
                                          labelText: 'Celular',
                                          labelStyle: TextStyle(color: Colors.white)),

                                      autocorrect: false,
                                      validator: (_) {
                                        return state.isTelefonoRequired ? 'Requiere este campo' : null;
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ],
                                );

                              }
                              return Container(height:50);
                            }
                            ),


                            Text('Localización',

                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff14DAE2))),
                            state.incindente.locationData != null? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {},
                              icon: const Icon(
                                  IconData(0xf193, fontFamily: 'MaterialIcons')),
                              label: Text("Localizado"),
                            ):ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                //SacarLocalizacionUsuario
                                BlocProvider.of<reportIncidentBloc>(context)
                                    .add(SacarLocalizacionUsuario());
                              },
                              icon: const Icon(
                                  IconData(0xf192, fontFamily: 'MaterialIcons')),
                              label: Text("Localizarme"),
                            ),

                          ]
                      );

                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Fotos: 5/${state.incindente.fotos!.length}',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Video: 1/${state.incindente.video == null ? 0 : 1}',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<reportIncidentBloc>(context)
                                .add(insertPhotoIncident(true));
                          },
                          heroTag: 'image1',
                          tooltip: 'Pick Multiple Image from gallery',
                          child: const Icon(Icons.photo_library),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<reportIncidentBloc>(context)
                                .add(insertPhotoIncident(false));
                          },
                          heroTag: 'image2',
                          tooltip: 'Take a Photo',
                          child: const Icon(Icons.camera_alt),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            BlocProvider.of<reportIncidentBloc>(context)
                                .add(insertVideoIncident(true));
                          },
                          heroTag: 'video0',
                          tooltip: 'Pick Video from gallery',
                          child: const Icon(Icons.video_library),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            BlocProvider.of<reportIncidentBloc>(context)
                                .add(insertVideoIncident(false));
                          },
                          heroTag: 'video1',
                          tooltip: 'Take a Video',
                          child: const Icon(Icons.videocam),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //_task!
                          BlocProvider.of<reportIncidentBloc>(context)
                              .add(inicialR());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        icon: const Icon(
                            IconData(0xf05bc, fontFamily: 'MaterialIcons')),
                        label: Text("Cancelar"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _buildUploadSend();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff14DAE2),
                        ),
                        icon: const Icon(IconData(58737,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true)),
                        label: Text(
                          "Enviar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      } else if (state.isPhones) {
        return phoneScreenW();
      }
      return Container();
    });
  }

  bool isSendButtonEnabled(homeReportIncidentState state) {
    return state.incindente.locationData != null;
  }

  void _onDescripcionChanged() {
    _reporIncidentBloc?.add(chaDescripcionUsuario(_descripcion.text));
  }

  void _buildUploadSend() {
    _reporIncidentBloc?.add(reportIncidentUploadToDb());
  }
  void _onTelefonoChanged() {
    _perfilViewBloc?.add(chaTelefonocionUsuario(_telefono.text));
  }
  void _onDNIChanged() {
    _perfilViewBloc?.add(chaDNIUsuario(_dni.text));
  }
}
