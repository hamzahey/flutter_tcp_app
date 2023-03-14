// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcp/cubits/socket_list/socket_state.dart';
import 'package:tcp/models/items.dart';
import 'package:tcp/pages/edit_goal.dart';
import 'package:tcp/pages/goals_screen.dart';
import 'package:tcp/pages/home.dart';
import 'package:tcp/pages/server.dart';
import 'package:tcp/widgets/drawer.dart';

import '../cubits/socket_list/socket_cubit.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../cubits/tcp_cubits/tcp_cubit.dart';

class Goals extends StatefulWidget {
  final socketList data;
  const Goals({
    required this.data,
  });

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  late socketList _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        title: Text(_data.address),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         context
                //             .read<TcpCubit>()
                //             .connect(_data.address, _data.port);
                //       },
                //       child: Icon(
                //         Icons.computer,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         context.read<TcpCubit>().disconnect();
                //       },
                //       child: Icon(
                //         Icons.light,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddGoals(
                        data: _data,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.battery_4_bar,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ), // first icon
                Container(
                  child: Icon(Icons.thermostat, size: 40),
                ),
                SizedBox(
                  width: 20,
                ), // second icon
                Container(child: Icon(Icons.location_history, size: 40)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 16.0, // Vertical spacing between items
                    crossAxisSpacing: 16.0, // Horizontal spacing between items
                    childAspectRatio: 1.0, // Aspect ratio of items
                  ),
                  itemCount:
                      _data.message?.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    EditGoals(data: _data, index: index))));
                      },
                      child: Container(
                        color: Colors.blueGrey,
                        child: Center(
                          child: Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_data.message?[index]),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
