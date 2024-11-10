import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

// cara menambahkan plugin
/**
 * 1. install extension yang namanya pubspec assist
 * 2. pencet f1 lalu search "pubspec assist"
 * 3. ketik plugin yang ingin digunakan lalu enter
 * 4. setelah install selesai, import ke file yang membutuhkan
 */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String body;
  late String id;
  late String email;
  late String nama;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    body = "belum ada data";
    id = "";
    email = "";
    nama = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("HTTP Request GET"),
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "id: $id",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "email: $email",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "nama: $nama",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              // fungsi bersifat asynchronous
              onPressed: () async {
                // sistem akan menunggu untuk mendapatkan data terlebih dahulu (menunggu fungsi get selesai)
                var myResponse = await http.get(
                  Uri.parse("https://reqres.in/api/users/5"),
                );
                // menampilkan data yang sudah didapatkan
                // print(myResponse.headers);
                // print(myResponse.statusCode);
                // print(myResponse.body);

                if (myResponse.statusCode == 200) {
                  // berhasil get data
                  print("Get data success");
                  // mengubah hasil get ke dalam bentuk objek
                  var data =
                      json.decode(myResponse.body) as Map<String, dynamic>;
                  // cetak data
                  print(data["data"]);
                  // memanggil fungsi setState untuk memperbarui state body
                  setState(() {
                    body = data["data"].toString();
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    nama =
                        "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                  });
                } else {
                  // gagal get data
                  print("Error ${myResponse.statusCode}");
                  setState(() {
                    body = "Error ${myResponse.statusCode}";
                  });
                }
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
