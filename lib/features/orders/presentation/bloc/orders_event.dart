part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class GetOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrdersEvent {
  final String orderName;
  final String customerName;
  final String customerAddress;
  final String amount;
  final String status;
  final String date;

  const CreateOrderEvent({
    required this.orderName,
    required this.customerName,
    required this.customerAddress,
    required this.amount,
    required this.status,
    required this.date,
  });

  @override
  List<Object?> get props => [
    orderName,
    customerName,
    customerAddress,
    amount,
    status,
    date,
  ];
}

class EditOrderEvent extends OrdersEvent {
  final String orderId;
  final String status;
  EditOrderEvent({required this.orderId, required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteOrderEvent extends OrdersEvent {
  final String id;

  const DeleteOrderEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
