part of 'information_bloc.dart';

abstract class InformationState extends Equatable {

  final InformationType informationType;

  const InformationState({@required this.informationType}):
   assert(informationType != null);

  @override
  List<Object> get props => [informationType];
}

class InformationInitial extends InformationState {
}

class InformationEmpty extends InformationState {}

class InformationLoading extends InformationState {}

class InformationLoaded extends InformationState {
  final InformationType informationType;

  const InformationLoaded({@required this.informationType}):
   assert(informationType != null);

  @override
  List<Object> get props => [informationType];
}

class InformationError extends InformationState {}