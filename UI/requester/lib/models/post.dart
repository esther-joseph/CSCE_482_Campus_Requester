class Post {
  final String postId;
  final String item;
  final String serviceFee;
  final String subTotal;
  final String total;
  final String description;
  final DateTime createdAt;
  final DateTime deliverBy;

  Post(
      {this.postId,
      this.item,
      this.serviceFee,
      this.subTotal,
      this.total,
      this.description,
      this.createdAt,
      this.deliverBy});

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'item': item,
      'serviceFee': serviceFee,
      'subTotal': subTotal,
      'total': total,
      'description': description,
      'createdAt': createdAt,
      'deliverBy': deliverBy,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Post(
        postId: map['postId'],
        item: map['item'],
        serviceFee: map['serviceFee'],
        subTotal: map['subTotal'],
        description: map['description'],
        createdAt: map['createdAt'],
        deliverBy: map['deliverBy']);
  }
}
