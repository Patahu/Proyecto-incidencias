import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/aunthentication_bloc/authentication_bloc.dart';
import '../../bloc/aunthentication_bloc/authentication_event.dart';
import '../../bloc/registerEnter_bloc/bloc.dart';
import 'register_buttom.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Dos variables
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm =
      TextEditingController();
  final TextEditingController _numeroTelefono =
  TextEditingController();
  final TextEditingController _dniUsuario =
  TextEditingController();
  late RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _passwordControllerConfirm.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    print(!state.isSubmitting);
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordControllerConfirm.addListener(_onPasswordChangedConfirm);
    _numeroTelefono.addListener(_onPhonedChanged);
    _dniUsuario.addListener(_onDNIChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
      // Si estado es submitting
      if (state.isSubmitting) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Registrando'),
                CircularProgressIndicator()
              ],
            ),
          ));
      }
      // Si estado es success
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        Navigator.of(context).pop();
      }
      // Si estado es failure
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Registro fallido'),
                Icon(Icons.error)
              ],
            ),
            backgroundColor: Colors.red,
          ));
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: ListView(
              children: <Widget>[
                // Un textForm para email
                TextFormField(
                  controller: _nombreController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      // ignore: unnecessary_const
                      icon: Icon(

                        IconData(0xe743, fontFamily: 'MaterialIcons'),
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                        color: Color(0xff14DAE2),
                      ),
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email,color: Color(0xff14DAE2)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return !state.isEmailValid ? 'Email inválido' : null;
                  },
                ),
                // Un textForm para password
                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock,color: Color(0xff14DAE2)),
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.white)),
                  obscureText: true,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Contraseña inválida'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _passwordControllerConfirm,

                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock,color: Color(0xff14DAE2)),
                      labelText: 'Confirmar contraseña',
                      labelStyle: TextStyle(color: Colors.white)),
                  obscureText: true,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return !state.isPasswordValidConfirm
                        ? 'Contraseña no válida, las contraseñas deben coincidir'
                        : null; //
                  },
                ),
                TextFormField(
                  controller: _numeroTelefono,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      icon: Icon(IconData(0xe4a3, fontFamily: 'MaterialIcons'),color: Color(0xff14DAE2)),
                      labelText: 'Celular',
                      labelStyle: TextStyle(color: Colors.white)),

                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                ),
                TextFormField(
                  controller: _dniUsuario,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      icon: Icon(IconData(0xe619, fontFamily: 'MaterialIcons'),color: Color(0xff14DAE2)),
                      labelText: 'DNI',
                      labelStyle: TextStyle(color: Colors.white)),

                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                ),
                // Un button
                RegisterButton(onPressed: () {
                  isRegisterButtonEnabled(state) ? _onFormSubmitted() : null;
                })
              ],
            ),
          ),
        );
      },
    ));
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }
  void _onPhonedChanged() {
    _registerBloc.add(PhoneChanged(numero: _numeroTelefono.text));
  }

  void _onDNIChanged() {
    _registerBloc.add(DNIChanged(numero: _dniUsuario.text));
  }

  void _onPasswordChangedConfirm() {
    _registerBloc.add(PasswordChangedCofirm(
        password: _passwordController.text,
        passwordCofirm: _passwordControllerConfirm.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        nombre: _nombreController.text,numero:_numeroTelefono.text,DNI:_dniUsuario.text));
  }
}
