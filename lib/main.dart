import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp5());
}

class MyApp5 extends StatelessWidget {
  const MyApp5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage5(),
    );
  }
}

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  List<Map<String, dynamic>> allUser = [];
  Future getAllUser() async {
    try {
      var response = await http.get(
        Uri.parse("https://reqres.in/api/users"),
      );
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        allUser.add(element);
      });

      print(allUser);
    } catch (e) {
      print("terjadi kesalahan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Future Builder"),
        ),
      ),
      // future builder
      // biar get data otomatis tanpa klik
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       // get data url api
      //       var response = await http.get(
      //         Uri.parse("https://reqres.in/api/users"),
      //       );
      //       List data =
      //           (json.decode(response.body) as Map<String, dynamic>)["data"];
      //       data.forEach((element) {
      //         Map<String, dynamic> user = element;
      //         print(user["email"]);
      //       });
      //     },
      //     child: Text("Click"),
      //   ),
      // ),

      body: FutureBuilder(
        future: getAllUser(),
        builder: (context, snapshot) {
          // snapshot untuk pengecekan loading data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return ListView.builder(
              itemCount: allUser.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  backgroundImage: NetworkImage(allUser[index]['avatar']),
                ),
                title: Text(
                    "${allUser[index]['first_name']} ${allUser[index]['last_name']}"),
                subtitle: Text("${allUser[index]['email']}"),
              ),
            );
          }
        },
      ),
    );
  }
}
