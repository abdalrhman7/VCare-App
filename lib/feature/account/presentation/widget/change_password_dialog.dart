import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/text_style.dart';
import '../../../../core/utilities/my_validators.dart';
import '../../../../core/widgets/default_text_form_filed.dart';

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog(
      {super.key,
        required this.passwordController,
        required this.passwordConfirmController});

  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final _passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                height: 0.34.sh,
                child: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: Form(
                    key: _passwordKey,
                    child: Column(
                      children: [
                        buildPasswordTextFormFiled(),
                        SizedBox(height: 20.h),
                        buildConfirmPasswordTextFormFiled(),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                passwordController.clear();
                                passwordConfirmController.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: Style.textStyle20
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_passwordKey.currentState?.validate() ==
                                    false) {
                                  return;
                                }
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Ok',
                                style: Style.textStyle20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text('Change password?'),
    );
  }

  Widget buildPasswordTextFormFiled() {
    return DefaultTextFormFiled(
      controller: passwordController,
      label: 'Password',
      hintText: 'Enter Your Password',
      validate: (value) => MyValidators.passwordValidator(value),
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildConfirmPasswordTextFormFiled() {
    return DefaultTextFormFiled(
      controller: passwordConfirmController,
      label: 'Confirm Password',
      hintText: 'Re Enter Your Password',
      validate: (value) => MyValidators.repeatPasswordValidator(
          password: passwordController.text, value: value),
      textInputAction: TextInputAction.done,
    );
  }
}