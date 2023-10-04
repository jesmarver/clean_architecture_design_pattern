import 'package:clean_architecture_design_pattern/core/services/injection_container.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_design_pattern/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:clean_architecture_design_pattern/src/authentication/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const HomeScreen(),
      ),
    );
  }
}
