import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../bloc/aunthentication_bloc/bloc.dart';
import '../../bloc/login_bloc/bloc.dart';

import '../../repository/user_repository.dart';
import '../buttons/create_account_button.dart';
import '../buttons/google_login_button.dart';
import '../buttons/login_button.dart';
import '../buttons/resetPasswordScreen.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc? _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      // tres casos, tres if:
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Ingreso Fallido'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
      if (state.isSubmitting) {
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Ingresando... '),
                CircularProgressIndicator(),
              ],
            ),
          ));
      }
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff3B324E),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email, color: Color(0xff14DAE2)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Email inválido' : null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff3B324E),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock, color: Color(0xff14DAE2)),
                        labelText: 'Contraseña',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white)),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid
                          ? 'Contraseña inválida'
                          : null;
                    },
                  ),
                ),
                ResetAccountButton(
                  userRepository: _userRepository,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Tres botones:
                      // LoginButton
                      LoginButton(onPressed: () {
                        isLoginButtonEnabled(state) ? _onFormSubmitted() : null;
                      }),
                      Column(
                        children: <Widget>[
                          Text(
                            '- O -',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Ingresar con',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      // GoogleLoginButton
                      GoogleLoginButton(),
                      // CreateAccountButton
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tiene una cuenta?',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CreateAccountButton(
                        userRepository: _userRepository,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc?.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc?.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc?.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
