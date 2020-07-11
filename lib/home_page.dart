import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 400.0,
            height: 600.0,
            child: Image.asset(
              'assets/image.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            child: Text(
              'Todos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DraggableScrollableSheet(
              maxChildSize: 0.85,
              builder: (BuildContext context, ScrollController controller) =>
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0),
                            topLeft: Radius.circular(16.0),
                          ),
                        ),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Task No $index',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'This is the Detail of Task No $index',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -28.0,
                        right: 32.0,
                        child: FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.pinkAccent,
                          onPressed: () {},
                        ),
                      )
                    ],
                  )),
        ],
      ),
    );
  }
}
