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
import 'package:get_task/features/auth/presentation/screens/auth_email_sign_in_screen.dart';
import 'package:get_task/features/home/presentation/screens/home_screen.dart';

class AuthEmailSignUpScreen extends StatefulWidget {
  const AuthEmailSignUpScreen({super.key});

  @override
  State<AuthEmailSignUpScreen> createState() => _AuthEmailSignUpScreenState();
}

class _AuthEmailSignUpScreenState extends State<AuthEmailSignUpScreen> {
  // Controllers
  final TextEditingController emailSignUpController = TextEditingController();
  final TextEditingController passwordSignUpController =
      TextEditingController();
  final TextEditingController userNameSignUpController =
      TextEditingController();

  // form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameSignUpController.dispose();
    emailSignUpController.dispose();
    passwordSignUpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Auth Email controller
    final AuthEmailController authEmailController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: KText(text: "Register", fontSize: 24),
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
              // Username TextField
              KTextField(
                validator: (value) => AppValidators.validateUserName(value),
                controller: userNameSignUpController,
                hintText: "UserName",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
              ),

              // Email TextField
              KTextField(
                validator: (value) => AppValidators.validateEmail(value),
                controller: emailSignUpController,
                hintText: "Email",
                prefixIcon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),

              // Password TextField
              KTextField(
                validator: (value) => AppValidators.validatePassword(value),
                controller: passwordSignUpController,
                hintText: "Password",
                prefixIcon: Icons.password,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              KVerticalSpacer(height: 30),

              // KFilledBtn
              Obx(
                () => KFilledBtn(
                  isLoading: authEmailController.isLoading.value,
                  label: authEmailController.isLoading.value
                      ? "Loading..."
                      : "Sign Up",
                  icon: Icons.login,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Form Valid
                      AppLogger.info("Form is Valid");

                      // Sign Up
                      authEmailController.signUpWithEmailPassword(
                        userNameSignUpController.text.trim(),
                        emailSignUpController.text.trim(),
                        passwordSignUpController.text.trim(),
                      );

                      // Success SnackBar
                      KSnackBar.success(
                        title: "SignUp",
                        message: "SignUp Successfully completed",
                      );

                      // Home Screen
                      Get.off(
                        () => HomeScreen(
                          userName: userNameSignUpController.text.trim(),
                        ),
                      );
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
                      text: "Already have an account? ",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),

                    // Sign Up
                    KTextBtn(
                      label: "Sign In",
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        // Sign In Screen
                        Get.to(() => AuthEmailSignInScreen());
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
