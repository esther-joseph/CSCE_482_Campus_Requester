class Post {
  final String title;
  final String imageUrl;
  final String description;

  Post({this.title, this.imageUrl, this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Post(
        title: map['title'],
        imageUrl: map['imageUrl'],
        description: map['description']);
  }
}
