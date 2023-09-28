import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/core/widgets/main_button.dart';
import 'package:vcare_app/feature/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:vcare_app/feature/auth/date/model/register_mode.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/function/main_snack_bar.dart';
import '../../../../../core/utilities/my_validators.dart';
import '../../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../../../../core/widgets/default_text_form_filed.dart';
import '../widget/build_register_or_login_here_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool male = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<RegisterCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let’s get started!",
                    style: TextStyle(fontSize: 32.sp),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "create an account and start booking now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                  ),
                  SizedBox(height: 20.h),
                  buildNameTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildEmailTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildPhoneTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildPasswordTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildConfirmPasswordTextFormFiled(),
                  SizedBox(height: 10.h),
                  buildMaleAndFemaleCheckbox(context),
                  BuildRegisterOrLoginHereButton(
                    text: 'Already have an account?',
                    buttonText: 'Login here',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.loginScreen),
                  ),
                  buildBlocConsumerMainButton(cubit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNameTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _nameController,
      label: 'Name',
      hintText: 'Enter Your Name',
      validate: (value) => MyValidators.nameValidator(value),
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildEmailTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _emailController,
      label: 'Email',
      hintText: 'Enter Your Email',
      validate: (value) => MyValidators.emailValidator(value),
      type: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildPhoneTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _phoneController,
      label: 'Phone',
      hintText: 'Enter Your Phone',
      validate: (value) => MyValidators.nameValidator(value),
      type: TextInputType.phone,
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildPasswordTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _passwordController,
      label: 'Password',
      hintText: 'Enter Your Password',
      validate: (value) => MyValidators.passwordValidator(value),
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildConfirmPasswordTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _passwordConfirmController,
      label: 'Confirm Password',
      hintText: 'Re Enter Your Password',
      validate: (value) => MyValidators.repeatPasswordValidator(
          password: _passwordController.text, value: value),
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildMaleAndFemaleCheckbox(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: kMainColor,
                checkColor: Colors.white,
                value: male,
                onChanged: (bool? value) {
                  setState(() {
                    male = value!;
                  });
                },
              ),
            ),
            Text(
              'Male',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).textScaleFactor * 18),
            )
          ],
        ),
        SizedBox(width: 20.w),
        Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: kMainColor,
                checkColor: Colors.white,
                value: !male,
                onChanged: (bool? value) {
                  setState(() {
                    male = !value!;
                  });
                },
              ),
            ),
            Text(
              'Female',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).textScaleFactor * 18),
            )
          ],
        ),
      ],
    );
  }

  Widget buildBlocConsumerMainButton(RegisterCubit cubit) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.bottomNavbar,
            (route) => false,
          );
        }
        if (state is RegisterError) {
          mainSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const CustomCircularProgressIndicator();
        }
        return MainButton(
          text: 'Register',
          onTap: () {
            validateAndSubmit(cubit);
          },
        );
      },
    );
  }

  void validateAndSubmit(RegisterCubit cubit) {
    if (_formKey.currentState!.validate()) {
      RegisterModel registerModel = RegisterModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        gender: (male) ? 0 : 1,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmController.text,
      );
      cubit.register(registerModel);
    }
  }
}
