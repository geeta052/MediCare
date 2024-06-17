import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/res/components/custom_button.dart';
import 'package:medicare/views/appointment_view/appointment_view.dart';

class DoctorProfile extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.color,
        title: const Text(
          "Doctor Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      height: 75,
                      width: 75,
                      child: Image.asset(
                        AppAssets.imgDoc,
                        fit: BoxFit.cover,
                      ),
                    ),
                    15.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        doc['docName']
                            .toString()
                            .text
                            .size(AppSizes.size18)
                            .make(),
                        doc['docCategory'].toString().text.make(),
                        8.heightBox,
                        VxRating(
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value: double.parse(doc['docRating'].toString()),
                          stepInt: true,
                        ),
                      ],
                    ),
                    const Spacer(),
                    "See All reviews".text.color(AppColors.primaryColor).make()
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "About".text.semiBold.size(AppSizes.size18).make(),
                    5.heightBox,
                    doc['docAbout']
                        .toString()
                        .text
                        .size(AppSizes.size14)
                        .make(),
                    10.heightBox,
                    "Address".text.semiBold.size(AppSizes.size18).make(),
                    5.heightBox,
                    doc['docAddress']
                        .toString()
                        .text
                        .size(AppSizes.size14)
                        .make(),
                    10.heightBox,
                    "Working Time"
                        .text
                        .semiBold
                        .size(AppSizes.size18)
                        .make(),
                    5.heightBox,
                    doc['docTiming']
                        .toString()
                        .text
                        .size(AppSizes.size14)
                        .make(),
                    10.heightBox,
                    "Services".text.semiBold.size(AppSizes.size18).make(),
                    5.heightBox,
                    doc['docService']
                        .toString()
                        .text
                        .size(AppSizes.size14)
                        .make(),
                    25.heightBox,
                    ListTile(
                      title: "Contact Details"
                          .text
                          .semiBold
                          .size(AppSizes.size16)
                          .make(),
                      subtitle: "First book an Appointment for contact details"
                          .text
                          .size(AppSizes.size12)
                          .make(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
            onTap: () {
              Get.to(
                () => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                  docNumber: doc['docPhone'],
                ),
              );
            },
            title: "Book an Appointment", buttonText: 'Book an Appointment',),
      ),
    );
  }
}
