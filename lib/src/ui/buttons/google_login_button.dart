import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/bloc.dart';
import 'package:auth_buttons/auth_buttons.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSocialBtn(context);
  }

  Widget _buildSocialBtn(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text('Ingresando...'),
              CircularProgressIndicator(),
            ],
          )));
          BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: AssetImage(
                'logos/Google.png',
              ),
            ),
          ),
        ));
  }
}
