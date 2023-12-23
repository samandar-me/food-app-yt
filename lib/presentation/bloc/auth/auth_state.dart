import 'package:equatable/equatable.dart';


abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState{}
class LoadingState extends AuthState{}
class ErrorState extends AuthState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
class SuccessState extends AuthState {}