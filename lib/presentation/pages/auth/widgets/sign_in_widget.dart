import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_status_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/buttons/custom_button.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/text_field/custom_text_field.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/text_field/password_text_field.dart';
import 'package:flutter_store_fic7/presentation/pages/dashboard/dashboard_page.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late GlobalKey<FormState> _fromKeyLogin;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailNode = FocusNode();
  final _passwdNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fromKeyLogin = GlobalKey<FormState>();
    context.read<AuthBloc>().add(const AuthEvent.refresh());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    if (_fromKeyLogin.currentState!.validate()) {
      _fromKeyLogin.currentState!.save();

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      context.read<AuthBloc>().add(
            AuthEvent.login(email: email, password: password),
          );
      context.read<AuthStatusBloc>().add(const AuthStatusEvent.check());
    }
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
          key: _fromKeyLogin,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
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
                  SnackBar(content: Text(authMessage)),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.marginSizeSmall,
                  ),
                  child: CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    focusNode: _emailNode,
                    nextNode: _passwdNode,
                    textInputType: TextInputType.emailAddress,
                    errorText: validatorMessages?['email']?[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.marginSizeSmall,
                  ),
                  child: PasswordTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    focusNode: _passwdNode,
                    textInputAction: TextInputAction.done,
                    errorText: validatorMessages?['password']?[0],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: Dimensions.marginSizeSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    checkColor: ColorResources.white,
                    activeColor: Theme.of(context).primaryColor,
                    value: false,
                    onChanged: (val) {},
                  ),
                  const Text(
                    'Remember',
                    style: titilliumRegular,
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Forgot Password',
                  style: titilliumRegular.copyWith(
                    color: ColorResources.lightSkyBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 30.0,
            bottom: 20.0,
            right: 20.0,
            left: 20.0,
          ),
          child: authState.maybeWhen(
            orElse: () => CustomButton(
              onTap: loginUser,
              buttonText: 'Sign In',
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        Center(
          child: Text(
            'OR',
            style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPage(),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(
              left: Dimensions.marginSizeAuth,
              right: Dimensions.marginSizeAuth,
              top: Dimensions.marginSizeAuthSmall,
            ),
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Continue as Guest',
              style: titleHeader.copyWith(
                color: ColorResources.getPrimary(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
