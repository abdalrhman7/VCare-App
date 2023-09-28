import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';

import '../../../../../core/function/main_snack_bar.dart';
import '../../../../../core/utilities/my_validators.dart';
import '../../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../../../../core/widgets/default_text_form_filed.dart';
import '../../../../../core/widgets/main_button.dart';
import '../../business_logic/login_cubit/login_cubit.dart';
import '../widget/build_register_or_login_here_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'nopy@nopy.com');
    _passwordController = TextEditingController(text: '123456');
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool keepMeLogin = false;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 36.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Login to access your assigned tasks and personal overview.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              buildEmailTextFormFiled(),
              SizedBox(
                height: 20.h,
              ),
              buildPasswordTextFormFiled(),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Checkbox(
                    value: keepMeLogin,
                    onChanged: (value) {
                      setState(() {
                        keepMeLogin = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'keep Me Logged In',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BuildRegisterOrLoginHereButton(
                text: 'No account yet?',
                buttonText: 'Register here.',
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen),
              ),
              SizedBox(height: 20.h),
              buildBlocConsumerMainButton(cubit),
            ],
          ),
        ),
      ),
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

  DefaultTextFormFiled buildPasswordTextFormFiled() {
    return DefaultTextFormFiled(
      controller: _passwordController,
      label: 'Password',
      hintText: 'Enter Your Password',
      validate: (value) => MyValidators.passwordValidator(value),
      type: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      isPassword: true,
    );
  }

  Widget buildBlocConsumerMainButton(LoginCubit cubit) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.bottomNavbar,
            (route) => false,
          );
        }
        if (state is LoginError) {
          mainSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CustomCircularProgressIndicator();
        }
        return MainButton(
          text: 'Login',
          onTap: () {
            validateAndSubmit(cubit);
          },
        );
      },
    );
  }

  void validateAndSubmit(LoginCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
