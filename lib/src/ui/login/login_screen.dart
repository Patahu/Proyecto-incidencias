import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/bloc.dart';
import '../../repository/data_base_firestores.dart';
import '../../repository/data_base_incidents.dart';
import '../../repository/user_repository.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color:Color(0xff251F34),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository: _userRepository),
            child: LoginForm(userRepository: _userRepository),
          ),
        ],
      ),
    );
  }
}
