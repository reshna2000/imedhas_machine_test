part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrdersEvent {
  final String orderName;
  final String customerName;
  final String customerAddress;
  final String amount;
  final String date;
  final String status;

  const CreateOrderEvent({
    required this.orderName,
    required this.customerName,
    required this.customerAddress,
    required this.amount,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [orderName, customerName, customerAddress, amount, date, status];
}

class GetOrdersEvent extends OrdersEvent {}
class EditOrderEvent extends OrdersEvent {
  final String orderId;
  final String status;

  EditOrderEvent({required this.orderId, required this.status});
}

class DeleteOrderEvent extends OrdersEvent {
  final String orderId;

  DeleteOrderEvent({required this.orderId});
}