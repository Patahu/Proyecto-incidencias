import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/resetPassword_bloc/bloc.dart';
import '../../repository/user_repository.dart';
import 'ResetForm.dart';

class ResetScreenForm extends StatelessWidget {
  final UserRepository _userRepository;

  ResetScreenForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Reiniciar',
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
          BlocProvider<ResetBloc>(
            create: (context) => ResetBloc(userRepository: _userRepository),
            child: ResetForm(userRepository: _userRepository),
          ),
        ],
      ),
    );
  }
}
