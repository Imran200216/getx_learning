import 'package:get_task/features/auth/domain/entities/user_entity.dart';
import 'package:get_task/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<UserEntity> call(String email, String password) {
    return authRepository.signIn(email, password);
  }
}
