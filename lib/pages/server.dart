import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/cubits/tcp_cubits/tcp_state.dart';
import 'package:tcp/models/items.dart';
import 'package:tcp/cubits/tcp_cubits/tcp_cubit.dart';
import 'package:tcp/models/message.dart';
import 'package:tcp/cubits/socket_list/socket_cubit.dart';
import 'package:tcp/cubits/socket_list/socket_state.dart';
import 'home.dart';
import 'package:connectivity/connectivity.dart';

class TcpClient extends StatefulWidget {
  @override
  _TcpClientState createState() => _TcpClientState();
}

class _TcpClientState extends State<TcpClient> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _messageController = TextEditingController();
  late bool flag_3 = false;

  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      flag_3 = true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Check interet Connectivity")));
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    bool flag_1 = false;
    bool flag_2 = false;
    return Scaffold(
      appBar: AppBar(title: Text('TCP Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _hostController,
                decoration: InputDecoration(labelText: 'Host'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a host';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _portController,
                decoration: InputDecoration(labelText: 'Port'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a port';
                  }
                  return null;
                },
              ),
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
                  if (_formKey.currentState!.validate()) {
                    flag_1 = true;
                    final host = _hostController.text;
                    final port = int.tryParse(_portController.text) ?? 0;
                    context.read<TcpCubit>().connect(host, port);
                  }
                },
                child: Text('Connect'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Message = _messageController.text;
                    context.read<TcpCubit>().send(Message);
                    flag_2 = true;
                  }
                },
                child: Text('Send Goal'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Message = _messageController.text;
                    context.read<TcpCubit>().disconnect();
                  }
                },
                child: Text('Disconnect'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      flag_1 == true &&
                      flag_2 == true && flag_3 == true) {
                    final host = _hostController.text;
                    final port = int.tryParse(_portController.text) ?? 0;
                    List<String> Message = [];
                    Message.add(_messageController.text);
                    Navigator.pop(
                        context,
                        socketList(
                            address: host, port: port, message: Message));
                  }
                },
                child: Text('Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
