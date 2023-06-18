import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourWidget extends StatelessWidget {

  Future<List<dynamic>> fetchJSONData() async {
  final response = await http.get(Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/programs'));
  if (response.statusCode == 200) {
    // If the request is successful, parse the JSON data
    final jsonData = jsonDecode(response.body);
    return jsonData['items'];
  } else {
    // If the request fails, throw an error or handle it accordingly
    throw Exception('Failed to fetch JSON data');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Access the fetched JSON data
            final items = snapshot.data;
            
            // Do something with the data (e.g., display it in a ListView)
            return ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                final category = item['category'];
                // Build your UI based on the category or other properties
                return ListTile(
                  title: Text(category),
                );
              },
            );
          } else if (snapshot.hasError) {
            // Handle any errors that occurred during the request
            return Text('Error: ${snapshot.error}');
          }
          
          // Display a loading spinner while waiting for the data
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
