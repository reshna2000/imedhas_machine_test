import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_app/core/app_navigation.dart';
import 'package:order_management_app/features/orders/presentation/bloc/orders_bloc.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => OrdersBloc(),)
    ], 
      child: MaterialApp.router(
        routerConfig: AppNavigator.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
