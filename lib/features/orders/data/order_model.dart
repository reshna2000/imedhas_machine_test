// order_model.dart
import 'dart:convert';

class OrderModel {
  final String? id;
  final String? orderName;
  final String? customerName;
  final DateTime? orderDate;
  final String? custAddress;
  final double? amount;
  final String? status;
  final String? username;

  OrderModel({
    this.id,
    this.orderName,
    this.customerName,
    this.orderDate,
    this.custAddress,
    this.amount,
    this.status,
    this.username,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['orderDate'] != null) {
      try {
        if (json['orderDate'] is int) {
          parsedDate = DateTime.fromMillisecondsSinceEpoch(json['orderDate']);
        } else if (json['orderDate'] is String) {
          parsedDate = DateTime.tryParse(json['orderDate']);
        }
      } catch (_) {
        parsedDate = null;
      }
    }

    double? parsedAmount;
    if (json['amount'] != null) {
      if (json['amount'] is num) {
        parsedAmount = (json['amount'] as num).toDouble();
      } else if (json['amount'] is String) {
        parsedAmount = double.tryParse(json['amount']);
      }
    }

    return OrderModel(
      id: json['id']?.toString(),
      orderName: json['orderName']?.toString(),
      customerName: json['customerName']?.toString(),
      orderDate: parsedDate,
      custAddress: json['custAddress']?.toString(),
      amount: parsedAmount,
      status: json['status']?.toString(),
      username: json['username']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'orderName': orderName,
    'customerName': customerName,
    'orderDate': orderDate?.toIso8601String(),
    'custAddress': custAddress,
    'amount': amount,
    'status': status,
    'username': username,
  };

  static List<OrderModel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return <OrderModel>[];
    return jsonList
        .map((e) => e is Map<String, dynamic>
        ? OrderModel.fromJson(e)
        : OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, orderName: $orderName, customerName: $customerName, orderDate: $orderDate, amount: $amount, status: $status)';
  }
}
