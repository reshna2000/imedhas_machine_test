part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final List<OrderModel> orderList;
  final OrderListingStatus status;
  const OrdersState({
    this.status = OrderListingStatus.initial,
    this.orderList = const [],
  });

  @override
  List<Object?> get props => [status, orderList];

  OrdersState copyWith({
    OrderListingStatus? status,
    List<OrderModel>? orderList,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orderList: orderList ?? this.orderList,
    );
  }

}
