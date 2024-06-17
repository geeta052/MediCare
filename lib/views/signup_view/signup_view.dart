import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/controllers/auth_controller.dart';
import 'package:medicare/res/components/custom_textfield.dart';
import 'package:medicare/res/components/loading_indicator.dart';
import 'package:medicare/views/home_view/home.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  AppAssets.imgSignup,
                  width: context.screenHeight * .18,
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.signupNow,
                  style: const TextStyle(
                    fontSize: AppSizes.size18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 2,
              child: Form(
                key: controller.formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        textcontroller: controller.nameController,
                        hint: AppStrings.fullname,
                        icon: const Icon(Icons.person),
                        validator: controller.validateName,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        textcontroller: controller.emailController,
                        icon: const Icon(Icons.email_outlined),
                        hint: AppStrings.emailHint,
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        textcontroller: controller.passwordController,
                        icon: const Icon(Icons.key),
                        hint: AppStrings.passwordHint,
                        validator: controller.validatePassword,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: context.screenWidth * .7,
                        height: 44,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () async {
                              controller.signupUser(context);
                              if (controller.userCredential != null) {
                                Get.offAll(() => const Home());
                              }
                            },
                            child: controller.isLoading.value
                                ? const LoadingIndicator()
                                : Text(
                                    AppStrings.signup,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.alreadyHaveAccount),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              AppStrings.login,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
