import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/controllers/auth_controller.dart';
import 'package:medicare/res/components/custom_textfield.dart';
import 'package:medicare/res/components/loading_indicator.dart';
import 'package:medicare/views/home_view/home.dart';
import 'package:medicare/views/reset_password/reset_password.dart';
import 'package:medicare/views/signup_view/signup_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f6),
      body: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  AppAssets.igLogin,
                  width: context.screenHeight * .30,
                ),
                5.heightBox,
                // AppStrings.welcome.text.size(AppSizes.size18).bold.make(),
                8.heightBox,
                AppStrings.weAreExcited.text
                    .size(AppSizes.size18)
                    .semiBold
                    .make()
              ],
            ),
            15.heightBox,
            Expanded(
              flex: 2,
              child: Form(
                  key: controller.formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          validator: controller.validateemail,
                          textcontroller: controller.emailController,
                          icon: const Icon(Icons.email_outlined),
                          hint: AppStrings.emailHint,
                        ),
                        18.heightBox,
                        CustomTextField(
                          validator: controller.validpass,
                          textcontroller: controller.passwordController,
                          icon: const Icon(Icons.key),
                          hint: AppStrings.passwordHint,
                        ),
                        20.heightBox,
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                Get.to(() => const PasswordResetPage());
                              },
                              child: "Forget Password ?".text.make()),
                        ),
                        20.heightBox,
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
                                await controller.loginUser(context);
                                if (controller.userCredential != null) {
                                  Get.offAll(() => const Home());
                                }
                              },
                              child: controller.isLoading.value
                                  ? const LoadingIndicator()
                                  : AppStrings.login.text.white.make(),
                            ),
                          ),
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppStrings.dontHaveAccount.text.make(),
                            8.widthBox,
                            AppStrings.signup.text
                                .color(AppColors.primaryColor)
                                .make()
                                .onTap(() {
                              Get.to(() => const SignupView());
                            }),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
