import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

import '../../resources/repository.dart';
//import '../../resources/file_stroage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;

  AuthBloc({@required this.repository});

  @override
  AuthState get initialState => NotAutenticated(error: 'INIT_STATE');

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    
    if (event is LoginEvent) {
      yield* _LoginAction(event.email, event.password);
    }
    else if (event is CheckAuthEvent) {
      yield* _CheckAuthAction();
    }
  }

  Stream<AuthState> _LoginAction(String email, String password) async* {
    try {
      yield Autenticating();

      final user = await this.repository.login(email, password);
      yield Autenticated(user: user);
    } catch (e) {
      yield NotAutenticated(error: e.toString());
    }
  }

  Stream<AuthState> _CheckAuthAction() async* {
    try {
      yield Autenticating();
      final user = await this.repository.loadUser();
      yield Autenticated(user: user);
    } catch (e) {
      yield NotAutenticated(error: e.toString());
    }
  }
}
