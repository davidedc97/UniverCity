import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Document> docs = List();
  List<Document> filteredDocs = List();

  _SearchState(){
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredDocs = docs;
        });
      } else {
        setState(() {
          _getDocs();
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
        ),
      ),
      body: _buildList(),
    );
  }


  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = List();
      for (int i = 0; i < filteredDocs.length; i++) {
        if (filteredDocs[i].title.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredDocs[i]);
        }
      }
      filteredDocs = tempList;
    }
    return ListView.builder(
      itemCount: docs == null ? 0 : filteredDocs.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredDocs[index].title),
          onTap: () => print(filteredDocs[index].title),
        );
      },
    );
  }

  void _getDocs() async {
    final List<Document> response = await HttpHandler.searchDocuments(_searchText);

    setState(() {
      docs = response;
      filteredDocs = docs;
    });
  }
  
}