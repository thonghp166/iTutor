import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Submitted extends RegisterEvent {
  final String email;
  final String phone;
  final String password;
  final String rePass;

  const Submitted({
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.rePass,
  });

  @override
  List<Object> get props => [email, phone, password, rePass];

  @override
  String toString() {
    return 'Submitted { email: $email, phone: $phone, password: $password , repear: $rePass}';
  }
}

class SignUp extends RegisterEvent {
  final String email;
  final String phone;
  final String password;

  const SignUp({
    @required this.email,
    @required this.phone,
    @required this.password,
  });

  @override
  List<Object> get props => [email, phone, password];

  @override
  String toString() {
    return 'SignUp { email: $email, phone: $phone, password: $password }';
  }
}