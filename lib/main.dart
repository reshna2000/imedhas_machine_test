import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_app/core/app_navigation.dart';
import 'package:order_management_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/orders/data/order_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrdersBloc(repository: OrdersRepository()),        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppNavigator.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
