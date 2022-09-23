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
    return const MaterialApp(
        title: "ListView.builder",
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
        home: ListViewBuilder());
  }
}

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  static var all = DateTime.now();
  static String day = all.day.toString();
  static String month = all.month.toString();
  static String year = all.year.toString().substring(2);
  TextEditingController date = TextEditingController(text: '$day-$month-$year');
  var lst = [];

  Future<void> getUsers(txt) async {
    Map<String, String> dct = {'date': date.text, 'group': 'Dart2022B'};

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
        onPressed: (() {
          // print(date);
          getUsers(date.text);
        }),
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: TextField(
          onSubmitted: getUsers,
          onChanged: getUsers,
          controller: date,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'date'),
        ),
      ),
      body: ListShow(lst: lst),
    );
  }
}

class ListShow extends StatelessWidget {
  const ListShow({
    Key? key,
    required this.lst,
  }) : super(key: key);

  final List lst;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
        });
  }
}
