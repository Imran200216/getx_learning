import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_task/commons/widgets/KFilledBtn.dart';
import 'package:get_task/commons/widgets/KSnackbar.dart';
import 'package:get_task/commons/widgets/KText.dart';
import 'package:get_task/commons/widgets/KTextField.dart';
import 'package:get_task/commons/widgets/KVerticalSpacer.dart';
import 'package:get_task/core/logger/app_logger.dart';
import 'package:get_task/core/validators/app_validators.dart';
import 'package:get_task/features/auth/presentation/controllers/auth_email_controller.dart';
import 'package:get_task/features/auth/presentation/screens/auth_email_sign_in_screen.dart';

class AuthEmailForgetPasswordScreen extends StatefulWidget {
  const AuthEmailForgetPasswordScreen({super.key});

  @override
  State<AuthEmailForgetPasswordScreen> createState() =>
      _AuthEmailForgetPasswordScreenState();
}

class _AuthEmailForgetPasswordScreenState
    extends State<AuthEmailForgetPasswordScreen> {
  // Controllers
  final TextEditingController emailForgetPasswordController =
      TextEditingController();

  // form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailForgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Auth Email controller
    final AuthEmailController authEmailController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: KText(text: "Forget Password", fontSize: 24),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Email TextField
              KTextField(
                validator: (value) => AppValidators.validateEmail(value),
                controller: emailForgetPasswordController,
                hintText: "Email",
                prefixIcon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),

              KVerticalSpacer(height: 30),

              // KFilledBtn
              Obx(
                () => KFilledBtn(
                  isLoading: authEmailController.isLoading.value,
                  label: authEmailController.isLoading.value
                      ? "Sending..."
                      : "Send Link",
                  icon: Icons.link,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Form Valid
                      AppLogger.info("Form is Valid");

                      // Reset Password
                      authEmailController.sentResetEmailPassword(
                        emailForgetPasswordController.text.trim(),
                      );

                      // Success SnackBar
                      KSnackBar.success(
                        title: "Success",
                        message: "Email Send Successfully",
                      );

                      // Login Screen
                      Get.off(() => AuthEmailSignInScreen());
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
            ],
          ),
        ),
      ),
    );
  }
}
