part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final OrderListingStatus status;
  final List<OrderModel> orders;
  final String? error;

  const OrdersState({
    this.status = OrderListingStatus.initial,
    this.orders = const [],
    this.error,
  });

  OrdersState copyWith({
    OrderListingStatus? status,
    List<OrderModel>? orders,
    String? error,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, orders, error];
}
