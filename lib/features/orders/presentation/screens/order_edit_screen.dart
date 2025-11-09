import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:order_management_app/core/enums.dart';
import 'package:order_management_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:order_management_app/resourses/style/colors_class.dart';
import 'package:order_management_app/resourses/widgets/app_text.dart';
import 'package:order_management_app/resourses/widgets/primary_button.dart';
import 'package:order_management_app/resourses/widgets/snackbar.dart';
import '../../data/order_model.dart';

class OrderEditScreen extends StatefulWidget {
  final OrderModel order;

  const OrderEditScreen({super.key, required this.order});

  @override
  State<OrderEditScreen> createState() => _OrderEditScreenState();
}

class _OrderEditScreenState extends State<OrderEditScreen> {
  late String selectedStatus;
  bool isDeleting = false;
  bool isEditing = false;
  bool isProcessing = false; // For global loading overlay

  final List<String> statusOptions = ["In Progress", "Completed", "Cancelled"];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.order.status ?? "In Progress";
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kPrimary,
        title: const AppText("Order Details", color: Palette.white),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Palette.white),
        ),
        actions: [
          if (order.status == "Completed" || order.status == "Cancelled")
            const SizedBox.shrink()
          else
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                setState(() => isEditing = !isEditing);
              },
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Palette.white),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Delete Order"),
                  content: const Text("Are you sure you want to delete this order?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: TextButton.styleFrom(foregroundColor: Palette.kPrimary),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.kPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const AppText("Delete", color: Colors.white),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                setState(() {
                  isDeleting = true;
                  isProcessing = true;
                });
                context.read<OrdersBloc>().add(DeleteOrderEvent(id: order.id!));
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state.status == OrderListingStatus.success && !isDeleting) {
                setState(() => isProcessing = false);
                SnackBars.custom(
                  context,
                  type: SnackBarType.success,
                  bgColor: Palette.green,
                  text: "Status Updated Successfully",
                );
                context.pop(true);
              }

              if (state.status == OrderListingStatus.success && isDeleting) {
                setState(() {
                  isDeleting = false;
                  isProcessing = false;
                });
                SnackBars.custom(
                  context,
                  type: SnackBarType.success,
                  bgColor: Palette.green,
                  text: "Order Deleted Successfully",
                );
                context.pop(true);
              }

              if (state.status == OrderListingStatus.error) {
                setState(() {
                  isDeleting = false;
                  isProcessing = false;
                });
                SnackBars.custom(
                  context,
                  type: SnackBarType.fail,
                  bgColor: Palette.redDark,
                  text: "Operation Failed. Please try again.",
                );
              }

              if (state.status == OrderListingStatus.loading) {
                setState(() => isProcessing = true);
              }
            },
            builder: (context, state) {
              final isLoading = state.status == OrderListingStatus.loading && !isDeleting;

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      order.orderName ?? '',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    AppText("Customer: ${order.customerName ?? ''}", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    AppText("Amount: ₹${order.amount?.toStringAsFixed(2) ?? '0.00'}",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    AppText(
                      "Order Date: ${order.orderDate != null ? '${order.orderDate!.day}/${order.orderDate!.month}/${order.orderDate!.year}' : ''}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          "Order Status",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        if (order.status == "Completed" || order.status == "Cancelled")
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              order.status ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: isEditing ? Colors.white : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isEditing
                                    ? Palette.kPrimary.withOpacity(0.5)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedStatus,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: isEditing ? Colors.black : Colors.grey,
                                ),
                                items: statusOptions.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: isEditing
                                    ? (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedStatus = newValue;
                                    });
                                  }
                                }
                                    : null,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (isEditing)
                      PrimaryButton(
                        text: "Update",
                        loading: isLoading,
                        onTap: () {
                          setState(() => isProcessing = true);
                          context.read<OrdersBloc>().add(
                            EditOrderEvent(orderId: order.id!, status: selectedStatus),
                          );
                        },
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),

            if (isProcessing)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                    child: const Center(
                      child: SpinKitCircle(
                        color: Palette.kPrimary,
                        size: 70,
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}