import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/button_item.dart';
import '../../../../widgets/text_field_item.dart';
import '../../../../widgets/touch_dismiss_keyboard_item.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ThemeData _themeData;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  String gender = 'Male'; // Default gender
  String city = 'Ho Chi Minh City'; // Default city
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingLoginState) {
          EasyLoading.show(status: state.message);
        } else if (state is SuccessLoginState) {
          EasyLoading.showSuccess(state.message).then((value) {
            Navigator.pop(context);
          });
        } else if (state is FailedLoginState) {
          EasyLoading.showError(state.message);
        }
      },
      builder: (context, state) {
        return TouchOutsideToDismissKeyboard(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormCustom(
                      hintText: 'Full Name',
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormCustom(
                          hintText: 'Date of Birth',
                          controller: dobController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      hintText: 'Phone Number',
                      controller: phoneController,
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF1E1C24),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: _colorScheme.primary, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: city,
                      onChanged: (String? newValue) {
                        setState(() {
                          city = newValue!;
                        });
                      },
                      items: <String>[
                        'Ho Chi Minh City',
                        'Hanoi',
                        'Da Nang',
                        'Can Tho',
                        'Hue'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF1E1C24),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: _colorScheme.primary, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      hintText: "Password",
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    ButtonCustom(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            BlocProvider.of<AuthBloc>(context).add(
                              RegisterEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                fullName: fullNameController.text,
                                dob: selectedDate,
                                phoneNumber: phoneController.text,
                                gender: gender,
                                city: city,
                              ),
                            );
                          } else {
                            EasyLoading.showError('Passwords do not match');
                          }
                        }
                      },
                      textButton: 'Register',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
