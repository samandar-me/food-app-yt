import 'package:food_app_yt/domain/repository/remote_repository.dart';

class OnLoginUseCase {
  final RemoteRepository remoteRepository;

  const OnLoginUseCase(this.remoteRepository);

  Future<bool> call() async {
    return await remoteRepository.login();
  }
}