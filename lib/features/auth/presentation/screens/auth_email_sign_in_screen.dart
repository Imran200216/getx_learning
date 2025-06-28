import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_task/commons/widgets/KFilledBtn.dart';
import 'package:get_task/commons/widgets/KSnackbar.dart';
import 'package:get_task/commons/widgets/KText.dart';
import 'package:get_task/commons/widgets/KTextBtn.dart';
import 'package:get_task/commons/widgets/KTextField.dart';
import 'package:get_task/commons/widgets/KVerticalSpacer.dart';
import 'package:get_task/core/logger/app_logger.dart';
import 'package:get_task/core/validators/app_validators.dart';
import 'package:get_task/features/auth/presentation/controllers/auth_email_controller.dart';
import 'package:get_task/features/auth/presentation/screens/auth_email_forget_password_screen.dart';
import 'package:get_task/features/auth/presentation/screens/auth_email_sign_up_screen.dart';
import 'package:get_task/features/home/presentation/screens/home_screen.dart';

class AuthEmailSignInScreen extends StatefulWidget {
  const AuthEmailSignInScreen({super.key});

  @override
  State<AuthEmailSignInScreen> createState() => _AuthEmailSignInScreenState();
}

class _AuthEmailSignInScreenState extends State<AuthEmailSignInScreen> {
  // Controllers
  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController =
      TextEditingController();

  // form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Auth Email controller
    final AuthEmailController authEmailController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: KText(text: "Login", fontSize: 24),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email TextField
              KTextField(
                validator: (value) => AppValidators.validateEmail(value),
                controller: emailSignInController,
                hintText: "Email",
                prefixIcon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),

              // Password TextField
              KTextField(
                validator: (value) => AppValidators.validatePassword(value),
                controller: emailSignInController,
                hintText: "Password",
                prefixIcon: Icons.password,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: KTextBtn(
                  label: "Forget Password?",
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    // Sign Up Screen
                    Get.to(() => AuthEmailForgetPasswordScreen());
                  },
                ),
              ),

              KVerticalSpacer(height: 30),

              //
              Obx(
                () => KFilledBtn(
                  isLoading: authEmailController.isLoading.value,
                  label: authEmailController.isLoading.value
                      ? "Loading..."
                      : "Sign In",
                  icon: Icons.login,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Form Valid
                      AppLogger.info("Form is Valid");

                      // Sign In
                      authEmailController.signInWithEmailPassword(
                        emailSignInController.text.trim(),
                        passwordSignInController.text.trim(),
                      );

                      // Success SnackBar
                      KSnackBar.success(
                        title: "SignIn",
                        message: "SignIn Successfully completed",
                      );

                      // Home Screen
                      Get.off(() => HomeScreen());
                    } else {
                      KSnackBar.error(
                        title: "Error",
                        message: "Something went wrong. Please try again.",
                      );

                      AppLogger.error("Form is invalid");
                    }
                  },
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 2,
                  children: [
                    // Don't have an account
                    KText(
                      text: "Don't have an account? ",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),

                    // Sign Up
                    KTextBtn(
                      label: "Sign Up",
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        // Sign Up Screen
                        Get.to(() => AuthEmailSignUpScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
