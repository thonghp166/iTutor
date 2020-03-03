import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:itutor/src/repository/user_repository.dart';
import 'package:itutor/src/validator/validation.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
      Stream<RegisterEvent> events,
      Stream<RegisterState> Function(RegisterEvent event) next,
      ) {
    final nonDebounceStream = events;
    return super.transformEvents(
      nonDebounceStream,
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password,event.rePass ,event.phone);
    } else if (event is SignUp) {
      yield* _mapSignUpToState(event.email, event.password,event.phone);
    }
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email,
      String password,
      String rePass,
      String phone,
      ) async* {
    if (Validators.isValidEmail(email)){
      if (Validators.isValidPhone(phone)){
        if (Validators.isValidPassword(password)){
          if (Validators.isValidRePassword(password, rePass)){
            yield state.update(isRePasswordValid: true);
            print("true repass finish");
            add(SignUp(email: email,phone: phone, password: password));
          } else {
            yield state.update(isRePasswordValid: false, isPasswordValid: true, isPhoneValid: true, isEmailValid: true);
          }
        } else {
          yield state.update(isPasswordValid: false,isRePasswordValid: true, isPhoneValid: true, isEmailValid: true);
        }
      } else {
        yield state.update(isPhoneValid: false,isPasswordValid: true, isRePasswordValid: true, isEmailValid: true);
      }
    } else {
      print("false email");
      yield state.update(isEmailValid: false, isPasswordValid: true, isPhoneValid: true, isRePasswordValid: true);
    }
  }

  Stream<RegisterState> _mapSignUpToState(String email, String password, String phone) async*{
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
        phone: phone,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}