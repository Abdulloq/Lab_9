import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/post.dart';
import 'network/rest_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Dio dio = Dio(); // This is the Dio instance used by Retrofit

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrofit Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(client: RestClient(dio)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final RestClient client;

  const MyHomePage({Key? key, required this.client}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = widget.client.getPosts(); // Call API when widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit + Dio Example')),
      body: FutureBuilder<List<Post>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found.'));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].body),
              );
            },
          );
        },
      ),
    );
  }
}