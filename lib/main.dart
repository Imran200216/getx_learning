import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_task/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:get_task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:get_task/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:get_task/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:get_task/features/auth/domain/usecases/signup_usecase.dart';
import 'package:get_task/features/auth/presentation/controllers/auth_email_controller.dart';
import 'package:get_task/features/auth/presentation/screens/auth_email_sign_in_screen.dart';
import 'package:get_task/features/counter/presentation/controller/counter_controller.dart';
import 'package:get_task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // DataSources
    final firebaseAuthDataSource = FirebaseAuthDataSource();

    // Auth Repository
    final authRepository = AuthRepositoryImpl(
      firebaseAuthDataSource: firebaseAuthDataSource,
    );

    // Use Cases
    final signInUseCase = SignInUseCase(authRepository: authRepository);
    final signUpUseCase = SignUpUseCase(authRepository: authRepository);
    final forgetPasswordUseCase = ForgetPasswordUseCase(
      authRepository: authRepository,
    );

    // GetX Controllers
    final CounterController counterController = Get.put(CounterController());
    final AuthEmailController authEmailController = Get.put(
      AuthEmailController(
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
        forgetPasswordUseCase: forgetPasswordUseCase,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Tutorial',
      home: AuthEmailSignInScreen(),
    );
  }
}
