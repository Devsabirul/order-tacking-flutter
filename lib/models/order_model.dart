class Order {
  int orderId;
  String date;
  String outletName;
  String outletAddress;
  double totalAmount;
  String remark;
  List<OrderItem> items; // List of order items

  Order({
    required this.orderId,
    required this.date,
    required this.outletName,
    required this.outletAddress,
    required this.totalAmount,
    required this.remark,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'date': date,
      'outletName': outletName,
      'outletAddress': outletAddress,
      'totalAmount': totalAmount,
      'remark': remark,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map, List<OrderItem> orderItems) {
    return Order(
      orderId: map['orderId'],
      date: map['date'],
      outletName: map['outletName'],
      outletAddress: map['outletAddress'],
      totalAmount: map['totalAmount'],
      remark: map['remark'],
      items: orderItems,
    );
  }
}

class OrderItem {
  int orderId; 
  String itemName;
  double price;
  double quantity;

  OrderItem({
    required this.orderId,
    required this.itemName,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'itemName': itemName,
      'price': price,
      'quantity': quantity,
    };
  }


  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      orderId: map['orderId'],
      itemName: map['itemName'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
