import 'package:app_cinema/apps/config/conf_colors.dart';
import 'package:app_cinema/widgets/button_item.dart';
import 'package:app_cinema/widgets/text_field_item.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late LoginBloc _blocLogin;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    _blocLogin = BlocProvider.of<LoginBloc>(context);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: TouchOutsideToDismissKeyboard(
        child: Scaffold(
          backgroundColor: ConfigColors().primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SingleChildScrollView(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is FaildLoginState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message!)));
                    }
                    if (state is SuccessLoginState) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingLoginState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return buildLoginForm(context, themeData);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context, ThemeData themeData) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Image.asset("assets/image/AppIcon.png"),
          const SizedBox(height: 30),
          TextFormCustom(
            hintText: 'Username',
            controller: usernameController,
          ),
          const SizedBox(height: 15),
          TextFormCustom(
            hintText: "Password",
            controller: passwordController,
            iconPrefix: Icons.lock,
            isPassword: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: themeData.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          ButtonCustom(
            onTap: () {
              if (formKey.currentState!.validate()) {
                _blocLogin.add(
                  LoginWithUsernamePasswordEvent(
                    username: usernameController.text,
                    password: passwordController.text,
                  ),
                );
              }
            },
            textButton: 'Login',
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            backgroundColor: themeData.colorScheme.primary,
          ),
          const SizedBox(height: 80),
          Column(
            children: [
              Text(
                "Or sigin with",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        _blocLogin
                            .add(ThirdPartyLoginEvent(provider: 'google'));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/image/google_logo.png",
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        _blocLogin
                            .add(ThirdPartyLoginEvent(provider: 'facebook'));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/image/facebook_logo.png",
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
