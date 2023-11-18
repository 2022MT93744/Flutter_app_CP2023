import 'package:flutter/material.dart';
import 'package:todotracker/main.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'imdbmain.dart';

class Firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  void addToDof() async {
    if (textEditingController1.text.trim().isEmpty || textEditingController2.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Task tracker"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveTodof(textEditingController1.text, textEditingController2.text);
    setState(() {
      textEditingController1.clear();
      textEditingController2.clear();
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to free up resources
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your task or todo lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController1,
              decoration: InputDecoration(labelText: 'Enter title'),
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: textEditingController2,
              decoration: InputDecoration(labelText: 'Enter Description'),
            ),
            SizedBox(height: 32.0),

            ElevatedButton(
              onPressed: addToDof,
              style: ElevatedButton.styleFrom(
                primary: Colors.purpleAccent,
                padding: EdgeInsets.all(28.0), // Adjust the padding as needed
              ),
              child: Text('Save in Database'),
            ),
            ElevatedButton(
                onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),
              ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                padding: EdgeInsets.all(20.0), // Adjust the padding as needed
              ),
              child: Text('Go to home page'),),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyimdbApp(),
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                padding: EdgeInsets.all(20.0), // Adjust the padding as needed
              ),
              child: Text('Go to IMDB page'),),
          ],
        ),
      ),
    );
  }

  Future<void> saveTodof(String title, String desc) async {
    final todo = ParseObject('Todo')..set('title', title)..set('description', desc)..set('done', false);
    await todo.save();
  }
}
