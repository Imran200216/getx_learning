import 'package:get_task/features/auth/domain/entities/user_entity.dart';
import 'package:get_task/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<UserEntity> call(String userName, String email, String password) {
    return authRepository.signUp(userName, email, password);
  }
}
