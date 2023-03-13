import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 180,
            color: Colors.blue,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 70,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.task,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              "Add Goal",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.bolt,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              "Add Robot",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.laptop_chromebook,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              "About Us",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              "Contact Us",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.close,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              "Exit",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
