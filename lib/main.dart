import 'package:api_integrations/bloc/user/user_bloc.dart';
import 'package:api_integrations/data/repositories/user_repository.dart';
import 'package:api_integrations/data/servicecs/api_services.dart';
import 'package:api_integrations/ui/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => UserBloc(UserRepository(ApiServicesUser())),
        child: const UserScreen(),
      ),
    );
  }
}
