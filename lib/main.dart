import 'package:flutter/material.dart';
import 'countries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<String> favoriteCounties = [];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    List countiesToBeDisplayed;
    if (pageIndex == 0) {
      countiesToBeDisplayed = countries;
    } else {
      countiesToBeDisplayed = [];
      for (var i = 0; i < countries.length; i++) {
        if (favoriteCounties.contains(countries[i]['name'])) {
          countiesToBeDisplayed.add(countries[i]);
        }
      }
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Countries App!'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'favorite'),
        ],
      ),
      body: ListView.builder(
        itemCount: countiesToBeDisplayed.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
            padding: EdgeInsets.all(8),
            color: Colors.white,
            height: 75,
            width: double.infinity,
            child: Row(
              children: [
                Image.network(
                  countiesToBeDisplayed[index]['flag'],
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    countiesToBeDisplayed[index]['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: favoriteCounties
                              .contains(countiesToBeDisplayed[index]['name'])
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (favoriteCounties
                          .contains(countiesToBeDisplayed[index]['name'])) {
                        favoriteCounties
                            .remove(countiesToBeDisplayed[index]['name']);
                      } else {
                        favoriteCounties
                            .add(countiesToBeDisplayed[index]['name']);
                      }
                      setState(() {});
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
