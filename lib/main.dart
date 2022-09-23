import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
        home: const ListViewBuilder());
  }
}

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  List lst1 = [
    {'full_name': 'Sardor Ruziqulov', 'ishere': true},
    {'full_name': 'Maxkambek Xolbekov', 'ishere': false},
    {'full_name': 'Muhammadlaziz Qurbonov', 'ishere': true},
    {'full_name': 'Ozodbek Musurmonov', 'ishere': true},
    {'full_name': 'Alisher Norxojayev', 'ishere': false},
    {'full_name': 'Sharof Imamov', 'ishere': true},
    {'full_name': 'Begzod Elmurodov', 'ishere': false}
  ];
  var lst = [];

  Future<void> getUsers() async {
    Map<String, String> dct = {'date': '22-08-22', 'group': 'Dart2022B'};

    var response = await http.get(
        Uri.parse(
          'http://127.0.0.1:8000/check',
        ),
        headers: dct);
    setState(() {
      lst = json.decode(response.body)['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUsers();
        },
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(title: const Text('24-08-22, Dart2022B')),
      body: ListView.builder(
          itemCount: lst.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              trailing: Text(
                lst[index]['ishere'] ? 'kelgan' : 'kelmagan',
                style: const TextStyle(color: Colors.green, fontSize: 15),
              ),
              onTap: () {},
              title: Text(lst[index]['full_name']),
            );
          }),
    );
  }
}
