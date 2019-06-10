import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_study_app/bloc/auth_bloc/bloc.dart';
import './bloc.dart';

import '../blocs.dart';
import '../../resources/auth_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthBloc authBloc;
  final AuthRepository authRepository;
  //StreamSubscription authSubscription;

  SigninBloc({@required this.authBloc, @required this.authRepository});

  @override
  SigninState get initialState => NotSignin();

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if(event is AttemptSigninEvent){
      yield* _mapToSigninActionToState(event.email, event.password);
    }
  }

  Stream<SigninState> _mapToSigninActionToState(String email, String password) async* {
    try {
      yield LoadingSignin();
      //await Future.delayed(const Duration(milliseconds: 3000));
      final user = await this.authRepository.login(email, password);
      yield SuccessSignin();

      authBloc.dispatch( CheckAuthEvent() );

    } catch (e) {
      yield FailSignin(error: e.toString());
    }
  }
}
