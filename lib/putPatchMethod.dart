import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage3(),
    );
  }
}

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  String hasilResponse = "Belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("HTTP Request PUT/PATCH"),
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            // memasang controller
            controller: nameController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            // memasang controller
            controller: jobController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              // menggunakan put
              // var response = await http.put(
              //   Uri.parse("https://reqres.in/api/users/2"),
              //   body: {
              //     // post body berupa text yang diambil dari controller
              //     "name": nameController.text,
              //     "job": jobController.text,
              //   },
              // );

              // menggunakan patch
              var response = await http.patch(
                Uri.parse("https://reqres.in/api/users/2"),
                body: {
                  // post body berupa text yang diambil dari controller
                  "name": nameController.text,
                  "job": jobController.text,
                },
              );
              print(response.body);
              Map<String, dynamic> data =
                  jsonDecode(response.body) as Map<String, dynamic>;
              setState(() {
                hasilResponse = "${data["name"]} - ${data["job"]}";
              });
            },
            child: Text("Submit"),
          ),
          SizedBox(
            height: 50,
          ),
          // garis horizontal sebagai pembagi
          Divider(),
          SizedBox(
            height: 10,
          ),
          Text(hasilResponse),
        ],
      ),
    );
  }
}
