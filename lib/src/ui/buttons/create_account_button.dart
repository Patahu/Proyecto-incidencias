import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';
import '../register/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text(
        'Crear cuenta',
        style: TextStyle(color: Color(0xff14DAE2)),
      ),
      padding: EdgeInsets.only(right: 0.0),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RegisterScreen(
            userRepository: _userRepository,
          );
        }));
      },
    );
  }
}
