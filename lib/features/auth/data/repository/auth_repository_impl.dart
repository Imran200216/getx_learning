import 'package:get_task/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:get_task/features/auth/domain/entities/user_entity.dart';
import 'package:get_task/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryImpl({required this.firebaseAuthDataSource});

  @override
  Future<void> forgetPassword(String email) {
    return firebaseAuthDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final user = await firebaseAuthDataSource.signInWithEmailPassword(
      email,
      password,
    );
    final username = await firebaseAuthDataSource.fetchUsername(user.uid);

    return UserEntity(uid: user.uid, email: user.email!, userName: username);
  }

  @override
  Future<UserEntity> signUp(
    String userName,
    String email,
    String password,
  ) async {
    final user = await firebaseAuthDataSource.signUpWithEmailPassword(
      userName,
      email,
      password,
    );
    final fetchedUsername = await firebaseAuthDataSource.fetchUsername(
      user.uid,
    );

    return UserEntity(
      uid: user.uid,
      email: user.email!,
      userName: fetchedUsername,
    );
  }
}
