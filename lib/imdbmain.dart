import 'package:flutter/material.dart';
import 'imdb_api.dart';
import 'main.dart';


class MyimdbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ImdbApi _imdbApi = ImdbApi();
  List<dynamic> _searchResults = [];

  _searchMovies() async {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final results = await _imdbApi.searchMovies(query);
      setState(() {
        _searchResults = results['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMDb Flutter App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Movies',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchMovies,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['year']),
                );
              },
            ),
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
        ],
      ),
    );
  }
}
