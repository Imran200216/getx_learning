import 'package:get/get.dart';
import 'package:get_task/features/auth/domain/entities/user_entity.dart';
import 'package:get_task/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:get_task/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:get_task/features/auth/domain/usecases/signup_usecase.dart';

class AuthEmailController extends GetxController {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthEmailController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.forgetPasswordUseCase,
  });

  // Observables
  RxBool isLoading = false.obs;
  Rxn<UserEntity> currentUser = Rxn<UserEntity>();
  RxnString error = RxnString();

  // Sign In with Email password
  Future<void> signInWithEmailPassword(String email, String password) async {
    isLoading.value = true;
    error.value = null;

    try {
      final user = await signInUseCase(email, password);

      currentUser.value = user;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  // Sign Up With Email Password
  Future<void> signUpWithEmailPassword(
    String userName,
    String email,
    String password,
  ) async {
    isLoading.value = true;
    error.value = null;

    try {
      final user = await signUpUseCase(userName, email, password);

      currentUser.value = user;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  // Forget Password
  Future<void> sentResetEmailPassword(String email) async {
    isLoading.value = true;
    error.value = null;

    try {
      await forgetPasswordUseCase(email);
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
