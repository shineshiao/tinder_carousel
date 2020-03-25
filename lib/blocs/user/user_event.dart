part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class FetchSampleUser extends UserEvent {
}

class FetchRandomUser extends UserEvent {
}
class LoadUser extends UserEvent {
  final User user;

  const LoadUser({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}