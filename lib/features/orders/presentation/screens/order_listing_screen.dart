import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:order_management_app/core/app_navigation.dart';
import 'package:order_management_app/core/enums.dart';
import 'package:order_management_app/core/size.dart';
import 'package:order_management_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:order_management_app/resourses/style/assets_paths.dart';
import 'package:order_management_app/resourses/style/colors_class.dart';
import 'package:order_management_app/resourses/style/text_style_class.dart';
import 'package:order_management_app/resourses/widgets/app_text.dart';
import '../widgets/order_card.dart';

class OrderListingScreen extends StatefulWidget {
  const OrderListingScreen({super.key});

  @override
  State<OrderListingScreen> createState() => _OrderListingScreenState();
}

class _OrderListingScreenState extends State<OrderListingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(GetOrdersEvent());
  }

  Future<void> _refreshOrders() async {
    context.read<OrdersBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.kPrimary,
        onPressed: () async {
          final result = await context.pushNamed(
            AppNavigator.createOrderScreen,
          );
          if (result == true) {
            _refreshOrders();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const AppText(
          "Orders",
          color: Palette.white,
          style: Styles.roboto18Medium,
        ),
        backgroundColor: Palette.black,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Are you sure you want to logout?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context); // close dialog
                                    try {
                                      await FirebaseAuth.instance.signOut();
                                      AppNavigator.router.goNamed(AppNavigator.loginScreen);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Logout failed. Please try again."),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.logout, color: Palette.white),
          ),


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            log("OrderListingStatus: ${state.status}");
            final orders = state.orders;

            if (state.status == OrderListingStatus.loading) {
              return Center(child: Lottie.asset(AssetsPaths.loadingAnimation));
            }

            if (state.status == OrderListingStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AssetsPaths.errorAnimation),
                    const AppText("Failed to load orders"),
                    TextButton(
                      onPressed: _refreshOrders,
                      child: AppText(
                        "Try Again",
                        style: Styles.roboto20.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.status == OrderListingStatus.success && orders.isEmpty) {
              return Center(child: Lottie.asset(AssetsPaths.emptyAnimation));
            }

            if (state.status == OrderListingStatus.success) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  deviceWidth(context) > 600
                      ? Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: orders[index]);
                      },
                    ),
                  )
                      : Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshOrders,
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(order: orders[index]);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(child: Lottie.asset(AssetsPaths.emptyAnimation));
          },
        ),
      ),
    );
  }
}
