import 'dart:convert';

// import 'package:gt_bank_mobile_app/model/new_post.dart';
import 'package:flutter_bug/model/photo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bug/model/post_list.dart';



  Future<List<Posts>> postList() async {
  var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
  return postsFromJson(response.body);
}
  Future<List<Photo>> photoList() async {
    var photo = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    return photoFromJson(photo.body);
  }









//  class Repo{
//    Future<List<Post>> pistList() async {
//   var url= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
//   final post=jsonDecode(url.body);
  
  

//   return post.map((json)=>Post.fromJson(json));
//   }
//  }


