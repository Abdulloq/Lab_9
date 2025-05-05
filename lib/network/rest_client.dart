import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/post.dart';

part "rest_client.dart";

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/posts")
  Future<List<Post>> getPosts();
}
