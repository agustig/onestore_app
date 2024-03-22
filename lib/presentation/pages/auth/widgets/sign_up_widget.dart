import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:onestore_app/presentation/pages/base_widgets/buttons/custom_button.dart';
import 'package:onestore_app/presentation/pages/base_widgets/text_field/custom_text_field.dart';
import 'package:onestore_app/presentation/pages/base_widgets/text_field/password_text_field.dart';
import 'package:onestore_app/utils/dimensions.dart';

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
  final _passwordConfirmationController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmationFocus = FocusNode();

  bool isEmailVerified = false;

  void addUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthBloc>().add(
            AuthEvent.register(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              passwordConfirmation: _passwordConfirmationController.text,
            ),
          );
      isEmailVerified = true;
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    context.read<AuthBloc>().add(const AuthEvent.refresh());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final validatorMessages =
        authState.whenOrNull(error: (_, messages) => messages);

    return ListView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      children: [
        Form(
          key: _formKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message, messages) {
                  if (message != null) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                loaded: (authMessage) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authMessage),
                    backgroundColor: Colors.blue,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSizeDefault,
                  ),
                  child: CustomTextField(
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                    focusNode: _nameFocus,
                    nextNode: _emailFocus,
                    capitalization: TextCapitalization.words,
                    controller: _nameController,
                    errorText: validatorMessages?['name']?[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeSmall,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                  ),
                  child: CustomTextField(
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    nextNode: _passwordFocus,
                    controller: _emailController,
                    errorText: validatorMessages?['email']?[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeSmall,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                  ),
                  child: PasswordTextField(
                    hintText: 'Password',
                    focusNode: _passwordFocus,
                    nextNode: _passwordConfirmationFocus,
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    errorText: validatorMessages?['password']?[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeSmall,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                  ),
                  child: PasswordTextField(
                    hintText: 'Password Confirmation',
                    focusNode: _passwordConfirmationFocus,
                    controller: _passwordConfirmationController,
                    textInputAction: TextInputAction.done,
                    errorText: validatorMessages?['password_confirmation']?[1],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(Dimensions.marginSizeLarge),
            child: authState.maybeWhen(
              orElse: () => CustomButton(
                onTap: addUser,
                buttonText: 'Sign Up',
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            )),
      ],
    );
  }
}
