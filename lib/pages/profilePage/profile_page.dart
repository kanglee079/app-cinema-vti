import 'package:app_cinema/apps/config/conf_colors.dart';
import 'package:app_cinema/widgets/date_picker_widget.dart';
import 'package:app_cinema/widgets/language_toggle_item.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';

import '../../widgets/gender_item.dart';
import '../../widgets/infor_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isReceiveNotification = false;
  DateTime _selectedDate = DateTime.now();
  Gender _selectedGender = Gender.Male;
  String dropdownValue = "Ho Chi Minh City";
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleGenderChanged(Gender gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>[
      "Ho Chi Minh City",
      "Hanoi",
      "Da Nang",
      "Can Tho",
      "Hue"
    ];

    void saveProfile() {
      DateTime selectedDate = DateTime.now();
      String selectedGender = "Male";

      print("Full Name: ${fullNameController.text}");
      print("Phone Number: ${phoneNumberController.text}");
      print("Email: ${emailController.text}");
      print(
          "Date of Birth: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
      print("Gender: $selectedGender");
      print("City: $dropdownValue");
    }

    return TouchOutsideToDismissKeyboard(
      child: Scaffold(
        backgroundColor: ConfigColors().primaryColor,
        appBar: AppBar(
          backgroundColor: ConfigColors().appBarColor,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: ConfigColors().iconColor,
            ),
          ),
          title: const Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: ConfigColors().iconColor,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/image/AppIcon.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Wayne Jackson',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Information",
                    style: TextStyle(
                      color: ConfigColors().iconColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    InfoRow(
                      title: "Fullname",
                      controller: fullNameController,
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "Date of birth",
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            DatePickerWidget(onDateChanged: _handleDateChanged),
                      ),
                    ),
                    InfoRow(
                      title: "Phone number",
                      isPhone: true,
                      controller: phoneNumberController,
                    ),
                    InfoRow(
                      title: "Email",
                      controller: emailController,
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "Gender",
                      child: GenderItem(onGenderChanged: _handleGenderChanged),
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "City",
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              style: const TextStyle(color: Colors.white),
                              dropdownColor: ConfigColors().primaryColor,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        saveProfile();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange,
                        ),
                        child: const Center(
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: ConfigColors().iconColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const InfoRow(
                      title: "Language",
                      isDeco: false,
                      child: LanguageToggle(),
                    ),
                    InfoRow(
                      title: "Receive notification",
                      isDeco: false,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: isReceiveNotification,
                          activeColor: Colors.orange,
                          onChanged: (bool value) {
                            setState(() {
                              isReceiveNotification = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
