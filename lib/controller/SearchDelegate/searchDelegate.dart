import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends SearchDelegate {
  TextEditingController _searchController = TextEditingController();

  get SearchController => _searchController;

  // List<String> data = [
  //   "android",
  //   "windows",
  //   "mac",
  //   "linux",
  //   "parrotOS",
  //   "mint"
  // ];

  List<String> recentSearch = [
    "Android",
    "Windows",
    "Mac",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Get.back());
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != null && SearchController.contains(query.toLowerCase())) {
      return ListTile(
        title: Text(
          query,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {},
      );
    } else if (query == "") {
      return Text("",
          style: TextStyle(
            color: Colors.black,
          ));
    } else {
      return ListTile(
        title: Text("No results found"),
        onTap: () {},
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: recentSearch.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recentSearch[index],
                style: TextStyle(
                  color: Colors.black,
                )),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {},
          );
        });
  }
}
