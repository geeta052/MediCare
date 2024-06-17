import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/controllers/auth_controller.dart';
import 'package:medicare/controllers/settings_controller.dart';
import 'package:medicare/res/components/custom_iconbutton.dart';
import 'package:medicare/views/login_view/login_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color,
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0), 
                            width: 2, 
                          ),
                          borderRadius: BorderRadius.circular(50), 
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AppAssets.iccLogin,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            10.widthBox,
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: controller.username.value.text.bold.make(),
                              ),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.edit),
                            //   onPressed: () {
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.email),
                            10.widthBox,
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: controller.email.value.text.bold.make(),
                              ),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.edit),
                            //   onPressed: () {
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.phone),
                            10.widthBox,
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: controller.phone.value.text.bold.make(),
                              ),
                            ),
                            // IconButton(
                            //   icon: const Icon(Icons.edit),
                            //   onPressed: () {
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      20.heightBox,
                      const Divider(),
                      20.heightBox,
                      CustomIconButton(
                        color: AppColors.color,
                        onTap: () {},
                        title: "Change Password",
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      10.heightBox,
                      CustomIconButton(
                        color: Colors.black.withOpacity(.4),
                        onTap: () {},
                        title: "Terms & Condition",
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.white,
                        ),
                      ),
                      10.heightBox,
                      CustomIconButton(
                        color: AppColors.redcolor,
                        onTap: () {
                          AuthController().signout();
                          Get.offAll(() => const LoginView());
                        },
                        title: "Logout",
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
