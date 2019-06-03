import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(@required this.email, @required this.password) : super([email, password]);

  @override
  String toString() => 'LoginEvent';
}

class CheckAuthEvent extends AuthEvent {
  @override
  String toString() => 'CheckAuthEvent';
}

