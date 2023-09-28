import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/constants/text_style.dart';

import '../../../../core/function/main_snack_bar.dart';
import '../../../../core/utilities/my_validators.dart';
import '../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../../../core/widgets/default_text_form_filed.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../auth/date/model/register_mode.dart';
import '../../business_logic/update_user_info_cubit/update_user_info_cubit.dart';
import '../widget/change_password_dialog.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late bool male;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    male = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<UpdateUserInfoCubit>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kMainColor,
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Update details!",
                      style: Style.textStyle32,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Update your info and become a new you !",
                    textAlign: TextAlign.center,
                    style: Style.textStyle22.copyWith(
                        color: Colors.grey, overflow: TextOverflow.fade),
                  ),
                  SizedBox(height: 20.h),
                  buildNameTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildEmailTextFormFiled(),
                  SizedBox(height: 20.h),
                  buildPhoneTextFormFiled(),
                  SizedBox(height: 20.h),
                  ChangePasswordDialog(
                      passwordController: _passwordController,
                      passwordConfirmController: _passwordConfirmController),
                  SizedBox(height: 10.h),
                  buildChangeGender(context),
                  SizedBox(height: 20.h),
                  buildBlocConsumerMainButton(cubit)
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

  Widget buildChangeGender(BuildContext context) {
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
              style: Style.textStyle16,
            )
          ],
        ),
        SizedBox(width: 20.h),
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
              style: Style.textStyle16,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBlocConsumerMainButton(UpdateUserInfoCubit cubit) {
    return BlocConsumer<UpdateUserInfoCubit, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserInfoError) {
          mainSnackBar(context, state.errorMessage);
        }
        if (state is UpdateUserInfoSuccess) {
          mainSnackBar(context, 'Success');
        }
      },
      builder: (context, state) {
        if (State is UpdateUserInfoLoading) {
          return const CustomCircularProgressIndicator();
        }
        return MainButton(
          text: 'Update',
          onTap: () {
            validateAndSubmit(cubit);
          },
        );
      },
    );
  }

  void validateAndSubmit(UpdateUserInfoCubit cubit) {
    if (_formKey.currentState!.validate()) {
      RegisterModel registerModel = RegisterModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        gender: (male) ? 0 : 1,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmController.text,
      );
      cubit.updateUserInfo(registerModel);
    }
  }
}
