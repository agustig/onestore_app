import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/injection.dart' as di;
import 'package:flutter_store_fic7/presentation/bloc/auth_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_status_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/auth/auth_page.dart';
import 'package:flutter_store_fic7/presentation/pages/dashboard/dashboard_page.dart';
import 'package:flutter_store_fic7/utils/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await di.locator.isReady<SharedPreferences>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<AuthStatusBloc>()..add(const AuthStatusEvent.check()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          context.read<AuthStatusBloc>().add(const AuthStatusEvent.check());
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: BlocBuilder<AuthStatusBloc, AuthStatusState>(
              builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const AuthPage(),
              authenticated: (authToken) => const DashboardPage(),
              loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
