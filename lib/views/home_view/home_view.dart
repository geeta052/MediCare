import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/consts/lists.dart';
import 'package:medicare/controllers/home_controller.dart';
import 'package:medicare/controllers/search_controller.dart';
import 'package:medicare/res/components/custom_textfield.dart';
import 'package:medicare/views/category_details_view/category_details_view.dart';
import 'package:medicare/views/search_view/search_view.dart';
import '../doctor_profile_view/doctor_profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var searchcontroller = Get.put(DocSearchController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color,
        title: Row(
          children: [
            AppStrings.welcome.text.color(Colors.white).make(),
            5.widthBox,
            "".text.make()
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // search section
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              color: AppColors.color,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textcontroller: searchcontroller.searchQueryController,
                      hint: AppStrings.search,
                      icon: const Icon(Icons.person_search_sharp),
                      backgroundColor: Colors.white,
                      textColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  10.widthBox,
                  IconButton(
                    onPressed: () {
                      Get.to(() => SearchView(
                            searchQuery:
                                searchcontroller.searchQueryController.text,
                          ));
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            4.heightBox,
            // Banner container
            BannerContainer(),
            4.heightBox,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: iconsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          // ontap for list
                          onTap: () {
                            Get.to(() => CategoryDetailsView(
                                catName: iconsTitleList[index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.bg1Color,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Image.asset(
                                  iconsList[index],
                                  width: 50,
                                ),
                                5.heightBox,
                                iconsTitleList[index].text.make()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  15.heightBox,
                  // popular doctors
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Popular Doctors",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  10.heightBox,
                  FutureBuilder<QuerySnapshot>(
                    future: controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: 240,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DoctorProfile(
                                        doc: data[index],
                                      ));
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 17, 177, 158),
                                        Color.fromARGB(255, 3, 107, 95),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: 160,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color: AppColors.greenColor,
                                          child: Image.asset(
                                            AppAssets.imgDoc,
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        data![index]['docName'],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data[index]['docCategory'],
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => DoctorProfile(
                                                doc: data[index],
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'View Profile',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  
                  20.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: const LinearGradient(
          colors: [    Color.fromARGB(255, 3, 107, 95),
 Color.fromARGB(207, 0, 0, 0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book Your Appointment Today!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Find the best doctors and book an appointment in just a few clicks.',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(228, 255, 254, 254),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Upto 45% OFF + Get 10% healthcash back',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
