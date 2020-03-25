import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/repositories/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchSampleUser) {
      yield* _mapFetchSampleToState(event);
    }
    if(event is FetchRandomUser) {
      yield* _mapFetchRandomToState(event);
    }
    if(event is LoadUser) {
      yield* _mapLoadUserToState(event);
    }
  }

  Stream<UserState> _mapFetchSampleToState(FetchSampleUser event) async* {
    yield UserLoading();
    try {
      final User user = userRepository.getSampleUser();
      yield UserLoaded(user: user);
    } catch (_) {
      yield UserError();
    }
  }
  Stream<UserState> _mapFetchRandomToState(FetchRandomUser event) async* {
    yield UserLoading();
    try {
      final User user = userRepository.getRandomUser();
      yield UserLoaded(user: user);
    } catch (_) {
      yield UserError();
    }
  }
  Stream<UserState> _mapLoadUserToState(LoadUser event) async* {
    yield UserEmpty();
    yield UserLoading();
    try {
      yield UserLoaded(user: event.user);
    } catch (_) {
      yield UserError();
    }
  }
}
