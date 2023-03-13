import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcp/cubits/socket_list/socket_state.dart';
import 'package:tcp/models/items.dart';
import 'package:tcp/pages/goals.dart';
import 'package:tcp/pages/server.dart';
import 'package:tcp/widgets/drawer.dart';

import '../cubits/socket_list/socket_cubit.dart';
import '../cubits/tcp_cubits/tcp_cubit.dart';

class AddGoals extends StatefulWidget {
  final socketList data;
  const AddGoals({required this.data});

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  late socketList _data;

  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // do something when the user presses the leading icon
          },
        ),
        title: Text("Add Goals"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFormField(
              //   controller: _hostController,
              //   decoration: InputDecoration(labelText: 'Host'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a host';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: _portController,
              //   decoration: InputDecoration(labelText: 'Port'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a port';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final host = _data.address.toString();
                  final port = int.tryParse(_data.port.toString()) ?? 0;
                  context.read<TcpCubit>().connect(host, port);
                },
                child: Text('Connect'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_messageController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Enter the Field")),
                      );
                    } else {
                      final Message = _messageController.text;
                      _data.message?.add(Message);
                      context.read<TcpCubit>().send(Message);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Goals(data: _data)));
                    }
                  });
                },
                child: Text('Send Message'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Disconnect'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
