import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  Color mainblue = Color(0xfff598BED);
  Widget box(String topic, Icon icon) {
    return InkWell(
      focusColor: Colors.red,
      hoverColor: Colors.red,
      highlightColor: Colors.red,
      splashColor: Colors.red,
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
            border: Border.all(color: mainblue, width: 2.3),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [icon, Text(topic)],
        ),
      ),
    );
  }

  Widget newCard(
      String img, String title, String subtitle, String lesson, bool check) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: 200,
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    color: mainblue, fontSize: 15, fontWeight: FontWeight.w700),
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
                              borderRadius: BorderRadius.circular(50))),
                    )
                  ],
                ),
              ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          )
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
              subtitle: Text('What Do you wanna learn Today',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                    )),
                box(
                    'Get Help',
                    Icon(
                      Icons.help,
                      color: mainblue,
                    )),
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
                    )),
                box(
                    'DD Tracker',
                    Icon(
                      Icons.track_changes_rounded,
                      color: mainblue,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                // color: Colors.amber,
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
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextButton(onPressed: () {}, child: Text('View all'))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          newCard(
                              'newBorn.jpg',
                              'Lifestyle',
                              'A complete guide for your new Born baby',
                              '16 Lessons',
                              false),
                          newCard(
                              'working.jpg',
                              'Working Women',
                              'A complete guide for working women',
                              '8 Lessons',
                              false)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                // color: Colors.amber,
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
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextButton(onPressed: () {}, child: Text('View all'))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          newCard('yoga.webp', 'Yoga',
                              'A complete guide for yoga', '15 Lessons', true),
                          newCard('dance.jpg', 'Dance', 'Dance classes',
                              '25 Lessons', true)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: mainblue,
          unselectedItemColor: mainblue,
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_sharp), label: 'Study'),
            BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore_sharp), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.co_present_rounded,
                ),
                label: 'Profile')
          ]),
    );
  }
}
