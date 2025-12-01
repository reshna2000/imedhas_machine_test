import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/enums.dart';
import '../../data/order_model.dart';
import '../../data/order_repository.dart';
part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository repository;

  OrdersBloc({required this.repository}) : super(const OrdersState()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<GetOrdersEvent>(_onGetOrders);
    on<EditOrderEvent>(_onEditOrder);
    on<DeleteOrderEvent>(_onDeleteOrder);
  }

  Future<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(status: OrderListingStatus.loading));

    try {
      await repository.createOrder(
        orderName: event.orderName,
        customerName: event.customerName,
        customerAddress: event.customerAddress,
        amount: double.tryParse(event.amount) ?? 0,
        date: event.date,
        status: event.status,
      );
      emit(state.copyWith(status: OrderListingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }

  Future<void> _onGetOrders(
    GetOrdersEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(status: OrderListingStatus.loading));

    try {
      final ordersList = await repository.getOrders();

      emit(
        state.copyWith(
          status: OrderListingStatus.success,
          orders: ordersList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }

  Future<void> _onEditOrder(EditOrderEvent event, Emitter emit) async {
    emit(state.copyWith(status: OrderListingStatus.loading));
    add(GetOrdersEvent());

    try {
      await repository.updateOrderStatus(event.orderId, event.status);
      emit(state.copyWith(status: OrderListingStatus.success));
    } catch (_) {
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }

  Future<void> _onDeleteOrder(DeleteOrderEvent event, Emitter emit) async {
    emit(state.copyWith(status: OrderListingStatus.loading));
    add(GetOrdersEvent());

    try {
      await repository.deleteOrder(event.orderId);
      emit(state.copyWith(status: OrderListingStatus.success));
    } catch (_) {
      emit(state.copyWith(status: OrderListingStatus.error));
    }
  }

}
