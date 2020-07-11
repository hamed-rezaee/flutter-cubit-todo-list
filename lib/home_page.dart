import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:flutter_cubit_todo/cubit/todo_cubit.dart';
import 'package:flutter_cubit_todo/models/todo_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoCubit _todoCubit;

  @override
  void initState() {
    super.initState();

    if (_todoCubit == null) {
      _todoCubit = CubitProvider.of<TodoCubit>(context);

      _todoCubit.getTodoList(true);
    }
  }

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
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: CubitBuilder<TodoCubit, TodoState>(
                    builder: (BuildContext context, TodoState state) {
                      if (state is TodoLoaded) {
                        return RefreshIndicator(
                          onRefresh: () async => _todoCubit.getTodoList(false),
                          child: ListView.builder(
                            controller: controller,
                            itemCount: state.models.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              isThreeLine: true,
                              title: Text(
                                state.models[index].title,
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                state.models[index].detail,
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
                        );
                      } else if (state is TodoError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
                    onPressed: () async {
                      showProgressDialog(context);
                      await _todoCubit.addNewItem(
                        TodoModel(
                          title: 'added by user',
                          detail: 'added by user detail.',
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16.0),
          Text(
            "Loading...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
