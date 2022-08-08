import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class ResetBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  UserRepository _userRepository;

  //Constructor
  ResetBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(ResetPasswordState.empty());

  ResetPasswordState get initialState => ResetPasswordState.empty();

  @override
  Stream<Transition<ResetPasswordEvent, ResetPasswordState>> transformEvents(
    Stream<ResetPasswordEvent> events,
    TransitionFunction<ResetPasswordEvent, ResetPasswordState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<ResetPasswordState> mapEventToState(
    ResetPasswordEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is Submitted) {
      yield* _mapLoginWithCredentialsPressedToState(email: event.email);
    }
  }

  Stream<ResetPasswordState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<ResetPasswordState> _mapLoginWithCredentialsPressedToState(
      {required email}) async* {
    yield ResetPasswordState.loading();
    try {
      await _userRepository.resetPassDB(email);
      yield ResetPasswordState.success();
    } catch (_) {
      yield ResetPasswordState.failure();
    }
  }
}
