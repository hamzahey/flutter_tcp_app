// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/cubits/socket_list/socket_state.dart';
import 'package:tcp/models/items.dart';
import 'package:tcp/pages/goals.dart';
import 'package:tcp/pages/server.dart';

import 'package:tcp/widgets/drawer.dart';

import '../cubits/socket_list/socket_cubit.dart';
import 'package:tcp/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final SocketListCubit socketListCubit = SocketListCubit();
  // List<socketList> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ));
        }),
        title: Text('TCP Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 16.0, // Vertical spacing between items
                    crossAxisSpacing: 16.0, // Horizontal spacing between items
                    childAspectRatio: 1.0, // Aspect ratio of items
                  ),
                  itemCount: items.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Goals(data: items[index]),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.blueGrey,
                        child: Center(
                          child: Icon(
                            Icons.lan,
                            size: 40,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TcpClient()),
          );
          if (newItem != null) {
            setState(() {
              items.add(newItem);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
