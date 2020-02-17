import 'package:flutter/services.dart';
import 'package:requester/models/post.dart';

class ApiService {
  //TODO implment addPost http call
  Future addPost(Post post) async {
    try {
      //http calls to add post add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getPosts() async {
    try {
      //http calls to add post
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
