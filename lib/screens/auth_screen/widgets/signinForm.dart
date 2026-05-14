import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/controller/auth_controller.dart';
import 'package:sankar_task/screens/auth_gateway/auth_gateway.dart';
import 'package:sankar_task/screens/auth_screen/widgets/passwordField.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final OutlineInputBorder inputBorder;
  final Color fillColor;
  final Color btnColor;
  final double scale;

  SignInForm({
    super.key,
    required this.formKey,
    required this.inputBorder,
    required this.fillColor,
    required this.btnColor,
    required this.scale,
  });

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.signInHeading,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16 * s,
              ),
            ),
            SizedBox(height: 6 * s),
            Text(
              AppConstants.signInSubheading,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.mutedGrey,
                height: 1.3,
                fontSize: 13 * s,
              ),
            ),
            SizedBox(height: 16 * s),

            Text(
              AppConstants.emailLabel,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 14 * s),
            ),
            SizedBox(height: 6 * s),
            TextFormField(
              controller: authController.loginEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppConstants.emailHint,
                filled: true,
                fillColor: fillColor,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14 * s,
                  vertical: 12 * s,
                ),
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder.copyWith(
                  borderSide: BorderSide(
                    color: AppColors.black12Op25,
                  ),
                ),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return AppConstants.emailRequired;
                }
                final ok = RegExp(AppConstants.emailRegex).hasMatch(v.trim());
                return ok ? null : AppConstants.invalidEmail;
              },
            ),
            SizedBox(height: 12 * s),

            Text(
              AppConstants.passwordLabel,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 14 * s),
            ),
            SizedBox(height: 6 * s),
            PasswordField(
              controller: authController.loginPassword,
              hint: AppConstants.passwordHint,
              inputBorder: inputBorder,
              fillColor: fillColor,
              s: s,
            ),
            SizedBox(height: 16 * s),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14 * s),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * s),
                    ),
                    foregroundColor: AppColors.black,
                  ),
                  onPressed: () async {
                    await authController.loginUser();
                    Get.offAll(AuthGateway());
                  },
                  child: authController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                          AppConstants.continueLabel,
                          style: TextStyle(
                            fontSize: 16 * s,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height:  10*s)
          ],
        ),
      ),
    );
  }
}
