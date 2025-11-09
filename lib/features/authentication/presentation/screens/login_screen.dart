import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:order_management_app/core/app_navigation.dart';
import 'package:order_management_app/core/enums.dart';
import 'package:order_management_app/core/size.dart';
import 'package:order_management_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:order_management_app/resourses/style/assets_paths.dart';
import 'package:order_management_app/resourses/widgets/snackbar.dart';
import '../../../../core/validator.dart';
import '../../../../resourses/style/colors_class.dart';
import '../../../../resourses/style/text_style_class.dart';
import '../../../../resourses/widgets/app_text.dart';
import '../../../../resourses/widgets/primary_button.dart';
import '../widgets/app_field_with_label.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Validators validators = Validators();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.success) {
                SnackBars.custom(
                  context,
                  type: SnackBarType.success,
                  bgColor: Palette.green,
                  text: "Login Success",
                );
                context.goNamed(AppNavigator.orderListingScreen);
              }

              if (state.authStatus == AuthStatus.error) {
                SnackBars.custom(
                  context,
                  type: SnackBarType.fail,
                  bgColor: Palette.redDark,
                  text: state.errorMessage ?? "Something went wrong",
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            setHeight(deviceHeight(context) * 0.1),
                            Center(
                              child: Lottie.asset(
                                AssetsPaths.loginAnimation,
                                height: deviceHeight(context) * 0.3,
                              ),
                            ),
                            AppText("Login", style: Styles.roboto30Bold),
                            AppText("Please enter your email id and password"),

                            AppFieldWithLabel(
                              validator: validators.emailValidator,
                              label: "Email",
                              hintText: "Enter your email",
                              controller: emailIdController
                                ..text = "username@gmail.com",
                              inputType: TextInputType.emailAddress,
                            ),

                            AppFieldWithLabel(
                              validator: validators.passwordValidator,
                              isObscure: true,
                              inputType: TextInputType.visiblePassword,
                              label: "Password",
                              hintText: "Enter your password",
                              controller: passwordController..text = "test@123",
                            ),


                          ],
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: keyboardHeight > 0 ? 0 : null,
                      child: keyboardHeight > 0
                          ? const SizedBox.shrink()
                          : SafeArea(
                        top: false,
                        child: PrimaryButton(
                          padding: const EdgeInsets.all(20),
                          loading:
                          state.authStatus == AuthStatus.loading,
                          text: "Login",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                UserLoginEvent(
                                  emailId: emailIdController.text
                                      .trim(),
                                  password: passwordController.text
                                      .trim(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
