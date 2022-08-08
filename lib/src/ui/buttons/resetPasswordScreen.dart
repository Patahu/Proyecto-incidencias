import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';
import '../resetScreen.dart/ResetForm.dart';
import '../resetScreen.dart/reset_password.dart';

class ResetAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  ResetAccountButton({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        child: const Text(
          '¿Olvidé mi contraseña?',
          style: TextStyle(color: Color(0xff14DAE2)),
        ),
        padding: EdgeInsets.only(right: 0.0),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ResetScreenForm(
              userRepository: _userRepository,
            );
          }));
        },
      ),
    );
  }
}
