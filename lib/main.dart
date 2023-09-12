import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/injection.dart' as di;
import 'package:flutter_store_fic7/presentation/bloc/auth_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/auth/auth_page.dart';
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
    return BlocProvider(
      create: (context) => di.locator<AuthBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: light,
        home: const AuthPage(),
      ),
    );
  }
}
