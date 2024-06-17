import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/controllers/appointment_controller.dart';
import 'package:medicare/res/components/custom_button.dart';
import 'package:medicare/res/components/custom_textfield.dart';

class BookAppointmentView extends StatelessWidget {
  final String docId;
  final String docNumber;
  final String docName;
  const BookAppointmentView({
    super.key,
    required this.docId,
    required this.docName,
    required this.docNumber,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color,
        title: docName.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Select Appointment date"
                    .text
                    .size(AppSizes.size16)
                    .semiBold
                    .make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appDayController,
                  hint: "Select date",
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
                10.heightBox,
                "Select Appointment Time"
                    .text
                    .size(AppSizes.size16)
                    .semiBold
                    .make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appTimeController,
                  hint: "Select time",
                  icon: const Icon(Icons.watch_later),
                ),
                10.heightBox,
                "Patient's name".text.size(AppSizes.size16).semiBold.make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appNameController,
                  hint: "Patient's full name",
                  icon: const Icon(Icons.person),
                ),
                10.heightBox,
                "Mobile Number".text.size(AppSizes.size16).semiBold.make(),
                CustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appMobileController,
                  hint: "Enter patent mobile number",
                  icon: const Icon(Icons.call),
                ),
                10.heightBox,
                "Your Problem".text.size(AppSizes.size16).semiBold.make(),
                TextFormField(
                  controller: controller.appMessageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.note_add),
                    hintText: "write your problem in short",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  onTap: () async {
                    await controller.bookAppointment(
                        docId, docName, docNumber, context);
                  },
                  title: "Confirm Appointment", buttonText: 'Confirm Appointment',
                ),
        ),
      ),
    );
  }
}
