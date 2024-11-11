import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage2(),
    );
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  // membuat controller untuk mengambil isi dari text field
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  String hasilResponse = "belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("HTTP Request POST"),
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
              var response = await http.post(
                Uri.parse("https://reqres.in/api/users"),
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
