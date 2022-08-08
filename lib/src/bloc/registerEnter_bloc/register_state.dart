import 'package:meta/meta.dart';

class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPasswordValidConfirm;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isPasswordValidConfirm;

  RegisterState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isPasswordValidConfirm,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure
  });

  // Estados:
  // Empty - vacio
  factory RegisterState.empty(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isPasswordValidConfirm: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false
    );
  }

  // Loading - cargando
  factory RegisterState.loading(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isPasswordValidConfirm:true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false
    );
  }

  // Failure - falla
  factory RegisterState.failure(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isPasswordValidConfirm:true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true
    );
  }

  // Sucess - exito
  factory RegisterState.success(){
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isPasswordValidConfirm:true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false
    );
  }

  // Update y copywith
  RegisterState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isPasswordValidConfirm,
    bool? isSubmitting,
    bool? isSucess,
    bool? isFailure
  }){
    return RegisterState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isPasswordValidConfirm: isPasswordValidConfirm ?? this.isPasswordValidConfirm,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSucess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }

  RegisterState update({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isPasswordValidConfirm
  }){
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isPasswordValidConfirm: isPasswordValidConfirm,
        isSubmitting: false,
        isSucess: false,
        isFailure: false
    );
  }

  @override
  String toString() {
    return ''' RegisterState{
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isPasswordValidConfirm: $isPasswordValidConfirm,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }
}