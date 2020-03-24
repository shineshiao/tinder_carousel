import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tinder_carousel/widgets/information.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  @override
  InformationState get initialState => InformationState(informationType: InformationType.personal);

  @override
  Stream<InformationState> mapEventToState(
    InformationEvent event,
  ) async* {
    if (event is InformationChanged) {
      yield InformationState(
        informationType: event.type,
      );
    }
  }
}
