import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SigninState extends Equatable {
  SigninState([List props = const []]) : super(props);
}
  
class LoadingSignin extends SigninState {

}

class NotSignin extends SigninState {
  
}

class SuccessSignin extends SigninState {
  @override
  String toString() => "SuccessSignin";
}

class FailSignin extends SigninState {
  final String error;

  FailSignin({@required this.error}) : super([error]);

  @override
  String toString() => "Not Signined => ${error}";
}