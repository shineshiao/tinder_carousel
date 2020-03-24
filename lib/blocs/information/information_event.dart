part of 'information_bloc.dart';

abstract class InformationEvent extends Equatable {
  const InformationEvent();

  @override
  List<Object> get props => [];
}

class InformationChanged extends InformationEvent {
  final InformationType type;
  
  const InformationChanged({@required this.type}) : assert(type != null);

  @override
  List<Object> get props => [type];
}