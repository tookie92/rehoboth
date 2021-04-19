import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'bloc.dart';

class BlocSign extends Bloc {
  final _streamController = StreamController<SignState>();

  Sink<SignState> get sink => _streamController.sink;
  Stream<SignState> get stream => _streamController.stream;

  void init() {
    final resultat =
        SignState(isActive: true, user: FirebaseAuth.instance.currentUser);
    sink.add(resultat);
  }

  BlocSign() {
    init();
  }

  @override
  dispose() {
    _streamController.close();
  }
}

class SignState {
  final bool isActive;
  final User? user;

  SignState({this.isActive = false, this.user});
}
