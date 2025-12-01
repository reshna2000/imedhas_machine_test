import 'dart:convert';
import 'package:intl/intl.dart';

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
    final rawDate = json['orderDate'];

    if (rawDate != null && rawDate.toString().trim().isNotEmpty) {
      try {
        if (rawDate is int) {
          parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate);
        } else if (rawDate is String) {
          parsedDate = DateTime.tryParse(rawDate);

          if (parsedDate == null) {
            parsedDate = DateFormat('dd/MM/yyyy').parse(rawDate);
          }

          if (parsedDate == null) {
            parsedDate = DateFormat('dd-MM-yyyy').parse(rawDate);
          }
        }
      } catch (_) {
        parsedDate = null;
      }
    }

    // ---- AMOUNT PARSING ----
    double? parsedAmount;
    final rawAmount = json['amount'];
    if (rawAmount != null) {
      if (rawAmount is num) {
        parsedAmount = rawAmount.toDouble();
      } else if (rawAmount is String) {
        parsedAmount = double.tryParse(rawAmount);
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
    // Always save in ISO format for consistency
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
        : OrderModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, orderName: $orderName, customerName: $customerName, orderDate: $orderDate, amount: $amount, status: $status)';
  }
}
