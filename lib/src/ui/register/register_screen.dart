import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registerEnter_bloc/bloc.dart';
import '../../repository/user_repository.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Registro',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xff14DAE2)),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xff251F34),
          ),
          Center(
            child: BlocProvider<RegisterBloc>(
              create: (context) =>
                  RegisterBloc(userRepository: _userRepository),
              child: RegisterForm(),
            ),
          ),
        ],
      ),
    );
  }
}
