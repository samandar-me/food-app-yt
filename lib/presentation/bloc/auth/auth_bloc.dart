import 'package:bloc/bloc.dart';
import 'package:food_app_yt/domain/use_case/on_login.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_event.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final OnLoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(InitialState()) {
    on<AuthEvent>((event, emit) async {
      if(event is OnLogin) {
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final response = await loginUseCase();
        if(response) {
          emit(SuccessState());
        } else {
          emit(const ErrorState('Error'));
        }
      }
    });
  }
}
