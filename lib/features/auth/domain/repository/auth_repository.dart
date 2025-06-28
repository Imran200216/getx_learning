import 'package:get_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // Sign Up
  Future<UserEntity> signUp(String userName, String email, String password);

  // Sign In
  Future<UserEntity> signIn(String email, String password);

  // Forget Password
  Future<void> forgetPassword(String email);
}
