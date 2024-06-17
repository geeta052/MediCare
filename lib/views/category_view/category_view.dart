import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';
import 'package:medicare/consts/lists.dart';
import 'package:medicare/views/category_details_view/category_details_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color,
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryImage.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            mainAxisExtent: 200,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView(
                      catName: categoryTitle[index],
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Image.asset(
                      categoryImage[index],
                      width: 110,
                    ),
                    const Divider(),
                    categoryTitle[index].text.size(AppSizes.size18).make(),
                    "13 Specialists".text.make()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
