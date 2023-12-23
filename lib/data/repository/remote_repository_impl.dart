import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/domain/repository/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  final AuthManager authManager;
  RemoteRepositoryImpl(this.authManager);

  @override
  Future<bool> login() async {
    return await authManager.signIn();
  }
}