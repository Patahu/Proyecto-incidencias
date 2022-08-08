import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/aunthentication_bloc/bloc.dart';
import '../../bloc/perfilView_bloc/bloc.dart';
import '../../bloc/registerEnter_bloc/bloc.dart';
import '../../util/authUser.dart';
class PerfilW extends StatefulWidget {
  final AuthUser _user;
  const PerfilW({Key? key,required AuthUser usuario}) :
        _user=usuario,
        super(key: key);

  @override
  _PerfilWState createState() => _PerfilWState();
}

class _PerfilWState extends State<PerfilW> {


  final TextEditingController _dniUsuario =
  TextEditingController();
  final TextEditingController _numeroTelefono =
  TextEditingController();
  final TextEditingController _nombreUsuario =
  TextEditingController();
  AuthUser get _user => widget._user;
  perfilViewBloc? _perfilViewBloc;
  @override
  void initState() {
    super.initState();
    _perfilViewBloc=BlocProvider.of<perfilViewBloc>(context);
    _numeroTelefono.text=_user.numero;
    _dniUsuario.text=_user.dni;
    _nombreUsuario.text=_user.nombre;
    _numeroTelefono.addListener(_onPhonedChanged);
    _dniUsuario.addListener(_onDNIChanged);
    _nombreUsuario.addListener(_onNombreChanged);


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement createElement
    final centroH = MediaQuery.of(context).size.height * 0.06;
    final centroW = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      body: BlocConsumer<perfilViewBloc,perfilViewtState>(
        listener:(context, state){

        },
          builder: (context, state){
          return Container(
            color:Color.fromARGB(255, 24, 40, 72),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 10,
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Perfil',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(64, 105, 225, 1),
                          ),
                        ))),

                buildUserInfoDisplay(state.usuarioAn.correo, 'Email'),
                BlocBuilder<perfilViewBloc,perfilViewtState>(
                    builder:(context,state){
                      if(state.isNombreEnable){
                        return buildUserInfoDisplayNotNombre(state.usuarioAn.nombre, 'Nombre');
                      }
                      return  buildUserInfoDisplayNombre(state.usuarioAn.nombre, 'Nombre',(!state.isTelefonoEnable  && !state.isDNIenable));
                    }
                ),

              BlocBuilder<perfilViewBloc,perfilViewtState>(
                builder:(context,state){
                  if(state.isDNIenable){
                    return buildUserInfoDisplayNotDNI(state.usuarioAn.dni, 'DNI');
                  }
                  return buildUserInfoDisplayDNI(state.usuarioAn.dni, 'DNI',!state.isTelefonoEnable && !state.isNombreEnable);
                }
              ),
                BlocBuilder<perfilViewBloc,perfilViewtState>(
                    builder:(context,state){
                      if(state.isTelefonoEnable){
                        return buildUserInfoDisplayNotTelefono(state.usuarioAn.numero, 'Número');
                      }
                      return buildUserInfoDisplayTelefono(state.usuarioAn.numero, 'Número',!state.isDNIenable && !state.isNombreEnable);
                    }
                ),

              //uildUserInfoDisplayD( 'DNI',context,true),
             // buildUserInfoDisplayT( 'Teléfono',context,true),

              ],
            ),
          );
        }
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          getValue,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ))),

              ]))
        ],
      ));
  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayNombre(String getValue, String title,bool isEnableEdit) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          getValue,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ))),
                IconButton(
                  icon: Icon(
                    const IconData(0xe89b, fontFamily: 'MaterialIcons'),
                    color: isEnableEdit? Color(0xff14DAE2):Colors.grey,
                    size: 35.0,
                  ),
                  onPressed: () {
                    if(isEnableEdit){
                      BlocProvider.of<perfilViewBloc>(context).add(chaNombreUsuarioEnable());
                    }

                  },
                ),
              ])),

        ],
      ));
  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayDNI(String getValue, String title,bool isEnableEdit) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          getValue,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ))),
                IconButton(
                  icon: Icon(
                    const IconData(0xe89b, fontFamily: 'MaterialIcons'),
                    color: isEnableEdit? Color(0xff14DAE2):Colors.grey,
                    size: 35.0,
                  ),
                  onPressed: () {
                    if(isEnableEdit){
                      BlocProvider.of<perfilViewBloc>(context).add(chaDNIUsuarioEnable());
                    }

                  },
                ),
              ]))
        ],
      ));

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayTelefono(String getValue, String title,bool isEnableEdit) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          getValue,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ))),
                IconButton(
                  icon: Icon(
                    const IconData(0xe89b, fontFamily: 'MaterialIcons'),
                    color: isEnableEdit? Color(0xff14DAE2):Colors.grey,
                    size: 35.0,
                  ),
                  onPressed: () {
                    if(isEnableEdit){
                      BlocProvider.of<perfilViewBloc>(context).add(chaTelefonoUsuarioEnable());
                    }

                  },
                ),
              ]))
        ],
      ));
  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayNotTelefono(String getValue, String title) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                height: 40,

                child: Row(children: [
                  Expanded(
                    child:    TextFormField(
                      controller: _numeroTelefono,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,

                    ),

                  ),
                  IconButton(
                    icon: const Icon(
                      IconData(0xef8c, fontFamily: 'MaterialIcons'),
                      color: Colors.green,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaDatasUsuarioDB());
                    },
                  ),
                  IconButton(

                    icon: const Icon(
                      IconData(0xe139, fontFamily: 'MaterialIcons'),
                      color: Colors.red,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaTelefonoUsuarioCancel());
                    },
                  ),

                ]))
          ],
        ));
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayNotNombre(String getValue, String title) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                height: 40,

                child: Row(children: [
                  Expanded(
                    child:    TextFormField(
                      controller: _nombreUsuario,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,

                    ),

                  ),
                  IconButton(
                    icon: const Icon(
                      IconData(0xef8c, fontFamily: 'MaterialIcons'),
                      color: Colors.green,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaDatasUsuarioDB());
                    },
                  ),
                  IconButton(

                    icon: const Icon(
                      IconData(0xe139, fontFamily: 'MaterialIcons'),
                      color: Colors.red,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaNombreUsuarioCancel());
                    },
                  ),

                ]))
          ],
        ));
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayNotDNI(String getValue, String title) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                height: 40,

                child: Row(children: [
                  Expanded(
                    child:    TextFormField(
                      controller: _dniUsuario,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                    ),

                  ),
                  IconButton(
                    icon: const Icon(
                      IconData(0xef8c, fontFamily: 'MaterialIcons'),
                      color: Colors.green,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaDatasUsuarioDB());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      IconData(0xe139, fontFamily: 'MaterialIcons'),
                      color: Colors.red,
                      size: 35.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<perfilViewBloc>(context).add(chaDNIUsuarioCancel());
                    },
                  ),

                ]))
          ],
        ));
  }
  void _onPhonedChanged() {
    _perfilViewBloc!.add(chaTelefonocionUsuario(_numeroTelefono.text));
  }

  void _onDNIChanged() {

    _perfilViewBloc!.add(chaDNIUsuario(_dniUsuario.text));
  }
  void _onNombreChanged() {

    _perfilViewBloc!.add(chaNombreUsuario(_nombreUsuario.text));
  }
}


