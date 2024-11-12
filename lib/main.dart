import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp4());
}

class MyApp4 extends StatelessWidget {
  const MyApp4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage4(),
    );
  }
}

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  String data = "belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("HTTP Request Delete"),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var response = await http.get(
                Uri.parse("https://reqres.in/api/users/2"),
              );

              Map<String, dynamic> myBody = json.decode(response.body);
              setState(() {
                data =
                    "AKUN: ${myBody["data"]["first_name"]} ${myBody["data"]["last_name"]}";
              });
            },
            icon: Icon(
              Icons.get_app,
            ),
          ),
        ],
        backgroundColor: Colors.blue[200],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(data),
          SizedBox(
            height: 35,
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await http.delete(
                Uri.parse("https://reqres.in/api/users/2"),
              );
              if (response.statusCode == 204) {
                setState(() {
                  data = "Berhasil menghapus data";
                });
              }
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }
}
