import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import '../../repository/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.empty());
  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  EventTransformer<Event> debounce<Event>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // Tres casos
    // Si el evento es EmailChanged
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    // Si el evento es PasswordChanged
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is PasswordChangedCofirm) {
      yield* _mapPasswordConfirmChangedToState(
          event.password, event.passwordCofirm);
    }
    // Si el evento es Submitted
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password,event.nombre,event.numero,event.DNI);
    }
    if(event is PhoneChanged) {

    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapPasswordConfirmChangedToState(
      String password, String passwordfirm) async* {
    yield state.update(
      isPasswordValidConfirm:
          (Validators.isValidPasswordConfirm(passwordfirm) &&
              password == passwordfirm),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email, String password, String nombre, String numero, String DNI) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
      await _userRepository.crearUsuarioDb(email,nombre,numero,DNI);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
