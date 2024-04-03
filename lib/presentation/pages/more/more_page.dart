import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/entities/user.dart';
import 'package:onestore_app/main.dart';
import 'package:onestore_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:onestore_app/presentation/bloc/auth_status/auth_status_bloc.dart';
import 'package:onestore_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:onestore_app/presentation/misc/methods.dart';
import 'package:onestore_app/utils/custom_theme.dart';

part 'methods/more_item.dart';
part 'methods/user_info.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final authStatusState = context.watch<AuthStatusBloc>().state;
    final profileBloc = context.watch<ProfileBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 75, 24, 24),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message, _) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaces(20),
              ...authStatusState.maybeWhen(
                authenticated: (token) {
                  return [
                    profileBloc.state.maybeWhen(
                      loaded: (user) => userInfo(user),
                      orElse: () => verticalSpaces(20),
                    ),
                    verticalSpaces(40),
                    const Text(
                      'Payment & Address',
                      style: titleHeader,
                    ),
                    verticalSpaces(20),
                    moreItem('Your Payments'),
                    verticalSpaces(20),
                    moreItem('Manage address book'),
                    verticalSpaces(20),
                    verticalSpaces(20),
                    const Text(
                      'Account Settings',
                      style: titleHeader,
                    ),
                    verticalSpaces(20),
                    moreItem('Update Profile'),
                    verticalSpaces(20),
                    moreItem('Change Password'),
                    verticalSpaces(20),
                    moreItem('Email preferences & Notifications'),
                    verticalSpaces(20),
                  ];
                },
                orElse: () {
                  return [];
                },
              ),
              verticalSpaces(20),
              const Text(
                'Preferences',
                style: titleHeader,
              ),
              verticalSpaces(20),
              moreItem('Contact Us'),
              verticalSpaces(20),
              moreItem('Privacy Policy'),
              verticalSpaces(20),
              moreItem('Terms and Conditions'),
              verticalSpaces(60),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: authStatusState.maybeWhen(
                    orElse: () => const CircularProgressIndicator(),
                    authenticated: (_) => ElevatedButton(
                      onPressed: () => authBloc.add(const AuthEvent.logout()),
                      child: const Text('Logout'),
                    ),
                    unauthenticated: () => ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (_) => false,
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
