import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SigninEvent extends Equatable {
  SigninEvent([List props = const []]) : super(props);
}


class AttemptSigninEvent extends SigninEvent{
  final String email;
  final String password;

  AttemptSigninEvent(@required this.email, @required this.password) : super([email, password]);

  @override
  String toString() => 'AttemptSigninEvent';
}