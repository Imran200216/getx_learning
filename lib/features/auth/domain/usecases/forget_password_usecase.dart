import 'package:get_task/features/auth/domain/repository/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository authRepository;

  ForgetPasswordUseCase({required this.authRepository});

  Future<void> call(String email) {
    return authRepository.forgetPassword(email);
  }
}
