import 'package:dio/dio.dart';
import '../network/rest_client.dart';

class ApiService {
  final RestClient client;

  // This constructor initializes the RestClient with Dio
  ApiService(Dio dio) : client = RestClient(dio);

  // This method calls the endpoint defined in RestClient
  Future getPosts() => client.getPosts();
}
