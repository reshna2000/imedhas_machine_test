import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:order_management_app/core/api_support.dart';
import 'package:order_management_app/core/dio_api_client.dart';
import 'package:order_management_app/core/enums.dart';
import 'package:order_management_app/features/orders/data/order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on<GetOrdersEvent>(_getOrdersEvent);
    on<CreateOrderEvent>(_createOrder);
    on<EditOrderEvent>(_editOrderEvent);
    on<DeleteOrderEvent>(_deleteOrderEvent);
  }

  FutureOr<void> _getOrdersEvent(GetOrdersEvent event,
      Emitter<OrdersState> emit,) async {
    log("Orders api calling");
    final dio = DioApiClient();

    emit(state.copyWith(status: OrderListingStatus.loading));

    try {
      final response = await dio.get(ApiSupport.order);

      if (response.statusCode == 200) {
        final orderList = OrderModel.fromJsonList(response.data);
        log(orderList.length.toString(), name: "ordersLength");

        emit(state.copyWith(
          status: OrderListingStatus.success,
          orderList: orderList,
        ));
      } else {
        emit(state.copyWith(status: OrderListingStatus.error));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }
  FutureOr<void> _createOrder(
      CreateOrderEvent event,
      Emitter<OrdersState> emit,
      ) async {
    final dio = DioApiClient();
    emit(state.copyWith(status: OrderListingStatus.loading));
    log("Creating order...");

    String formattedDate = "";
    try {
      if (event.date != null) {
        if (event.date is DateTime) {
          formattedDate = DateFormat('yyyy-MM-dd').format(event.date as DateTime);
        } else if (event.date is String) {
          final parsed = DateTime.tryParse(event.date);
          if (parsed != null) {
            formattedDate = DateFormat('yyyy-MM-dd').format(parsed);
          } else {
            formattedDate = DateFormat('yyyy-MM-dd').format(
              DateFormat('dd/MM/yyyy').parse(event.date),
            );
          }
        }
      }
    } catch (e) {
      log("Date formatting error: $e");
      formattedDate = "";
    }

    final payload = {
      "orderName": event.orderName,
      "customerName": event.customerName,
      "orderDate": formattedDate,
      "custAddress": event.customerAddress,
      "amount": event.amount,
      "status": event.status,
    };

    try {
      final response = await dio.post(ApiSupport.order, data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(status: OrderListingStatus.success));
        add(GetOrdersEvent());
      } else {
        emit(state.copyWith(status: OrderListingStatus.error));
      }
    } catch (e) {
      log("Create order error: $e");
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }


  FutureOr<void> _editOrderEvent(EditOrderEvent event, Emitter<OrdersState> emit) async {
    final dio = DioApiClient();
    emit(state.copyWith(status: OrderListingStatus.loading));

    try {
      final response = await dio.put("${ApiSupport.order}/${event.orderId}", data: {
        "status": event.status,
      });

      if (response.statusCode == 200) {
        add(GetOrdersEvent());
        emit(state.copyWith(status: OrderListingStatus.success));
      } else {
        emit(state.copyWith(status: OrderListingStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }



  FutureOr<void> _deleteOrderEvent(DeleteOrderEvent event,
      Emitter<OrdersState> emit,) async {
    final dio = DioApiClient();
    emit(state.copyWith(status: OrderListingStatus.loading));

    try {
      final response = await dio.delete("${ApiSupport.order}/${event.id}");

      if (response.statusCode == 200) {
        add(GetOrdersEvent());
      } else {
        emit(state.copyWith(status: OrderListingStatus.error));
      }
    } catch (e) {
      log("Delete order error: $e");
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }
}
