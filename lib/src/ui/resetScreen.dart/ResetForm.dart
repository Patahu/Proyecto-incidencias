import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/resetPassword_bloc/bloc.dart';
import '../../repository/user_repository.dart';
import 'resetButton.dart';

class ResetForm extends StatefulWidget {
  final UserRepository _userRepository;

  ResetForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  // Dos variables
  final TextEditingController _emailController = TextEditingController();
  ResetBloc? _resetBloc;
  bool isResetButtonEnabled(ResetPasswordState state) {
    return state.isFormValid && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _resetBloc = BlocProvider.of<ResetBloc>(context);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetBloc, ResetPasswordState>(
        listener: (context, state) {
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
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Ingresado'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.green,
            ),
          );
        Navigator.of(context).pop();
      }
    }, child: BlocBuilder<ResetBloc, ResetPasswordState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Tres botones:
                      // LoginButton
                      ResetButton(onPressed: () {
                        isResetButtonEnabled(state) ? _onFormSubmitted() : null;
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  void _onEmailChanged() {
    _resetBloc!.add(EmailChanged(email: _emailController.text));
  }

  void _onFormSubmitted() {
    _resetBloc!.add(Submitted(email: _emailController.text));
  }
}
