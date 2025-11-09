import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:order_management_app/core/size.dart';
import 'package:order_management_app/features/authentication/presentation/widgets/app_field_with_label.dart';
import 'package:order_management_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:order_management_app/resourses/widgets/app_text.dart';
import 'package:order_management_app/resourses/widgets/primary_button.dart';

import '../../../../core/enums.dart';
import '../../../../core/validator.dart';
import '../../../../resourses/style/colors_class.dart';
import '../../../../resourses/style/text_style_class.dart';
import '../../../../resourses/widgets/snackbar.dart';

class OrderCreateScreen extends StatefulWidget {
  const OrderCreateScreen({super.key});

  @override
  State<OrderCreateScreen> createState() => _OrderCreateScreenState();
}

class _OrderCreateScreenState extends State<OrderCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final orderNameController = TextEditingController();
  final customerNameController = TextEditingController();
  final amountController = TextEditingController();
  final addressController = TextEditingController();
  final datePickerController = TextEditingController();
  final Validators validators = Validators();

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Create Order",
          color: Palette.white,
          style: Styles.roboto18Medium,
        ),
        backgroundColor: Palette.black,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Palette.white),
        ),
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state.status == OrderListingStatus.success) {
            SnackBars.custom(
              context,
              type: SnackBarType.success,
              bgColor: Palette.green,
              text: "Order Created Successfully",
            );

            context.read<OrdersBloc>().add(GetOrdersEvent());
            context.pop(true);
          } else if (state.status == OrderListingStatus.error) {
            SnackBars.custom(
              context,
              type: SnackBarType.fail,
              bgColor: Palette.redDark,
              text: "Failed To Create Order",
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == OrderListingStatus.loading;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        spacing: 12,
                        children: [
                          AppFieldWithLabel(
                            validator: validators.nameValidator,
                            label: "Order Name",
                            controller: orderNameController,
                          ),
                          AppFieldWithLabel(
                            validator: validators.nameValidator,
                            label: "Customer Name",
                            controller: customerNameController,
                          ),
                          AppFieldWithLabel(
                            validator: (value) => validators.customValidator(
                              value,
                              "Please enter customer address",
                            ),
                            label: "Customer Address",
                            controller: addressController,
                          ),
                          AppFieldWithLabel(
                            validator: (value) =>
                                validators.customValidator(value, "Please enter amount"),
                            label: "Amount",
                            controller: amountController,
                            inputType: TextInputType.number,
                          ),
                          AppFieldWithLabel(
                            validator: (value) => validators.customValidator(
                              value,
                              "Please select a date",
                            ),
                            label: "Order Date",
                            controller: datePickerController,
                            isDatePicker: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: keyboardHeight > 0 ? 0 : null,
                    child: keyboardHeight > 0
                        ? const SizedBox.shrink()
                        : SafeArea(
                      top: false,
                      child: PrimaryButton(
                        padding: const EdgeInsets.all(20),
                        loading: isLoading,
                        text: "Create",
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            SnackBars.custom(
                              context,
                              type: SnackBarType.alert,
                              bgColor: Palette.grey,
                              text: "Please fill all required fields",
                            );
                            return;
                          }

                          context.read<OrdersBloc>().add(
                            CreateOrderEvent(
                              orderName: orderNameController.text,
                              customerName: customerNameController.text,
                              customerAddress: addressController.text,
                              amount: amountController.text,
                              date: datePickerController.text,
                              status: "In Progress",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
