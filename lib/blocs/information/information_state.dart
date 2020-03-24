part of 'information_bloc.dart';

class InformationState extends Equatable {
  final InformationType informationType;

  const InformationState({@required this.informationType}):
   assert(informationType != null);

  @override
  List<Object> get props => [];
}
