import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/injection.dart' as di;
import 'package:flutter_store_fic7/presentation/bloc/login_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/register_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/auth/auth_page.dart';
import 'package:flutter_store_fic7/utils/light_theme.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<RegisterBloc>()),
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: light,
        home: const AuthPage(),
      ),
    );
  }
}
