import 'dart:convert';

import 'package:banao_tech/app/modules/home/views/si.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  late Future<List<dynamic>> futureData;

  Future<List<dynamic>> fetchJSONData() async {
    final response = await http.get(
        Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/programs'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['items'];
    } else {
      throw Exception('Failed to fetch JSON data');
    }
  }

  Future<List<dynamic>> fetchJSONDatalesson() async {
    final response = await http.get(
        Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/lessons'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['items'];
    } else {
      throw Exception('Failed to fetch JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainblue = Color(0xfff598BED);

    Widget box(String topic, Icon icon) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => YourWidget()));
        },
        child: Container(
          height: 50,
          width: 170,
          decoration: BoxDecoration(
            border: Border.all(color: mainblue, width: 2.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(topic),
            ],
          ),
        ),
      );
    }

    Widget newCard(
      String img,
      String title,
      String subtitle,
      String lesson,
      bool check,
    ) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Card(
              elevation: 5,
              child: Container(
                width: 200,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/' + img,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: mainblue,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(subtitle),
                    ),
                    if (!check)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(lesson),
                      ),
                    if (check)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(lesson),
                            TextButton(
                              onPressed: () {},
                              child: Text('Book Now'),
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainblue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.grey,
        elevation: 0,
        leading: const Icon(Icons.menu_open_rounded),
        actions: const [
          Icon(Icons.message_outlined),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Hello, Harsh Nainwaya!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'What Do you wanna learn Today',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box(
                  'Programs',
                  Icon(
                    Icons.menu_book,
                    color: mainblue,
                  ),
                ),
                box(
                  'Get Help',
                  Icon(
                    Icons.help,
                    color: mainblue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box(
                  'Learn',
                  Icon(
                    Icons.language_rounded,
                    color: mainblue,
                  ),
                ),
                box(
                  'DD Tracker',
                  Icon(
                    Icons.track_changes_rounded,
                    color: mainblue,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Programs for you',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('View all'),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: FutureBuilder<List<dynamic>>(
                        future: fetchJSONData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            var data = snapshot.data!;
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var item = data[index];
                                  var lesson = item['lesson'].toString();
                                  var category = item['category'].toString();
                                  var name = item['name'].toString();

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: newCard(
                                      'newBorn.jpg',
                                      category,
                                      name,
                                      lesson,
                                      false,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Text('No data available.');
                            }
                          } else {
                            return Text('No data available.');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Events and Experiences',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('View all'),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: FutureBuilder<List<dynamic>>(
                        future: fetchJSONDatalesson(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            var data = snapshot.data!;
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var item = data[index];
                                  var name = item['name'].toString();
                                  var category = item['category'].toString();
                                  var duration =
                                      double.parse(item['duration'].toString());

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: newCard(
                                      'working.jpg',
                                      category,
                                      name,
                                      duration.toString(),
                                      true,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Text('No data available.');
                            }
                          } else {
                            return Text('No data available.');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: mainblue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
