class Post {
  final String postId;
  final String item;
  final String serviceFee;
  final String subTotal;
  final String total;
  final String description;
  final DateTime createdAt;
  final DateTime deliverBy;
  final String name;
  final double latitude;
  final double longitude;
  final String placeId;

  Post(
      {this.postId,
      this.item,
      this.serviceFee,
      this.subTotal,
      this.total,
      this.description,
      this.createdAt,
      this.deliverBy,
      this.name,
      this.latitude,
      this.longitude,
      this.placeId});

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
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'placeId': placeId
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
        deliverBy: map['deliverBy'],
        name: map['name'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        placeId: map['placeId']);
  }
}
