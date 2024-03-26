import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/main.dart';
import 'package:onestore_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:onestore_app/presentation/bloc/auth_status/auth_status_bloc.dart';
import 'package:onestore_app/presentation/misc/methods.dart';
import 'package:onestore_app/presentation/pages/more/widgets/more_item.dart';
import 'package:onestore_app/utils/custom_theme.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final authStatusState = context.watch<AuthStatusBloc>().state;
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
              // if authStatusState ...[],
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
