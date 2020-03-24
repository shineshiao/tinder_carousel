import 'dart:async';

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
      yield* _mapFetchUserToState(event);
    }
  }

    Stream<UserState> _mapFetchUserToState(FetchSampleUser event) async* {
    yield UserLoading();
    try {
      final User user = userRepository.getSampleUser();
      yield UserLoaded(user: user);
    } catch (_) {
      yield UserError();
    }
  }
}
