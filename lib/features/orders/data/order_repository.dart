import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_model.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore;

  OrdersRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createOrder({
    required String orderName,
    required String customerName,
    required String customerAddress,
    required double amount,
    required String date,
    String status = "In Progress",
  }) async {
    final docRef = _firestore.collection('orders').doc();

    await docRef.set({
      'id': docRef.id,
      'orderName': orderName,
      'customerName': customerName,
      'custAddress': customerAddress,
      'amount': amount,
      'orderDate': date,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<OrderModel>> getOrders() async {
    final snapshot = await _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OrderModel.fromJson(data);
    }).toList();
  }

  Future<void> updateOrderStatus(String? orderId, String status) async {
    if (orderId == null) return;
    await _firestore.collection('orders').doc(orderId).update({'status': status});
  }

  Future<void> deleteOrder(String? orderId) async {
    if (orderId == null) return;
    await _firestore.collection('orders').doc(orderId).delete();
  }
}
