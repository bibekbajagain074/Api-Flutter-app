import 'dart:convert';

import 'package:api/model/data-model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './utlity/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cat> postlist = [];

  //get item
  Future<List<Cat>> getData() async {
    var response = await http.get(Uri.parse("https://catfact.ninja/breeds"));

    if (response.statusCode == 200) {
      List<Cat> myCats = [];
      final data = response.body;
      var jsonData = jsonDecode(data);
      for (var catData in jsonData['data']) {
        myCats.add(Cat.fromapi(catData));
      }
      return myCats;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Breeds'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          // Check if the Future hasData
          if (snapshot.hasData) {
            // If the Future hasData, cast the data as a List of Cat objects
            List<Cat> apiData = List<Cat>.from(snapshot.data as List<Cat>);
            // Return a ListView builder that creates a ListTile for each Cat object
            return ListView.builder(
              itemCount: apiData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        "${apiData[index].breed!} ${apiData[index].origin!}",
                        style: CustomTextstyle.Mbold),
                    subtitle: Text(
                        "${apiData[index].coat!} ${apiData[index].pattern!}"),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // If the Future has an Error, return a Text widget
            return Text("Error getting data");
          } else {
            // If the Future is still Waiting, return a CircularProgressIndicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
