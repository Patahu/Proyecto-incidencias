class ResetPasswordState {
  // Definir variables
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isFormValid => isEmailValid;
  ResetPasswordState(
      {required this.isEmailValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});
  // Cuatro estados
  // -Vacio, empty
  factory ResetPasswordState.empty() {
    return ResetPasswordState(
        isEmailValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  // -cargando, loading
  factory ResetPasswordState.loading() {
    return ResetPasswordState(
        isEmailValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }
  // -Falla, failure
  factory ResetPasswordState.failure() {
    return ResetPasswordState(
        isEmailValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }
  // -Exito, success
  factory ResetPasswordState.success() {
    return ResetPasswordState(
        isEmailValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }
  // Funciones adicionales: copywith - update
  ResetPasswordState copyWith(
      {bool? isEmailValid,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure}) {
    return ResetPasswordState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  ResetPasswordState update({bool? isEmailValid}) {
    return copyWith(
        isEmailValid: isEmailValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  @override
  String toString() {
    // TODO: implement toString
    return ''' LoginState {
      isEmailValid: $isEmailValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }
}
