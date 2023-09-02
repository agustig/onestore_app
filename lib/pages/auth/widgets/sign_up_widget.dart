import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/pages/base_widgets/buttons/custom_button.dart';
import 'package:flutter_store_fic7/pages/base_widgets/text_field/custom_text_field.dart';
import 'package:flutter_store_fic7/pages/base_widgets/text_field/password_text_field.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late final GlobalKey<FormState> _formKey;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool isEmailVerified = false;

  void addUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      isEmailVerified = true;
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.marginSizeDefault,
                ),
                child: Expanded(
                  child: CustomTextField(
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                    focusNode: _nameFocus,
                    nextNode: _emailFocus,
                    capitalization: TextCapitalization.words,
                    controller: _nameController,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimensions.marginSizeSmall,
                  left: Dimensions.marginSizeDefault,
                  right: Dimensions.marginSizeDefault,
                ),
                child: Expanded(
                  child: CustomTextField(
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    nextNode: _passwordFocus,
                    controller: _emailController,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimensions.marginSizeSmall,
                  left: Dimensions.marginSizeDefault,
                  right: Dimensions.marginSizeDefault,
                ),
                child: Expanded(
                  child: PasswordTextField(
                    hintText: 'Password',
                    focusNode: _passwordFocus,
                    nextNode: _confirmPasswordFocus,
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimensions.marginSizeSmall,
                  left: Dimensions.marginSizeDefault,
                  right: Dimensions.marginSizeDefault,
                ),
                child: Expanded(
                  child: PasswordTextField(
                    hintText: 'Password Confirmation',
                    focusNode: _confirmPasswordFocus,
                    controller: _confirmPasswordController,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(Dimensions.marginSizeLarge),
          child: CustomButton(onTap: addUser, buttonText: 'Sign Up'),
        ),
      ],
    );
  }
}
