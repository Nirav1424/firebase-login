import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> model = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    height: 140,
                    color: const Color.fromARGB(255, 214, 82, 82),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User id : ${model[index].userId}',
                          style: const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' id : ${model[index].id}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          ' Title : ${model[index].title}',
                          style: const TextStyle(fontSize: 18,color: Colors.white),
                          maxLines: 1,
                        ),
                        Text(
                          ' body : ${model[index].body}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<List<Model>> getdata() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        model.add(Model.fromJson(index));
      }
      return model;
    } else {
      return model;
    }
  }
}
