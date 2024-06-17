import 'package:flutter/material.dart';
import 'package:medicare/consts/colors.dart';
import 'package:medicare/views/category_view/category_view.dart';
import 'package:medicare/views/home_view/home_view.dart';
import 'package:medicare/views/settings_view/settings_view.dart';
import 'package:medicare/views/total_appointment_view/total_appointment_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List screenList = [
    const HomeView(),
    const TotalAppointment(),
    // const BookAppointmentView(docId: '', docName: '', docNumber: '',),
    const CategoryView(),
    // const LoginView(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: "Home"),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), label: "Appointments"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(
          //     icon: Icon(Icons.person), label: "Doctors"),
          // BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
