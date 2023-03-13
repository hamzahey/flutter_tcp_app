import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcp/cubits/socket_list/socket_state.dart';
import 'package:tcp/models/items.dart';
import 'package:tcp/models/message.dart';
import 'package:tcp/pages/goals.dart';
import 'package:tcp/pages/server.dart';
import 'package:tcp/widgets/drawer.dart';

import '../cubits/socket_list/socket_cubit.dart';
import '../cubits/tcp_cubits/tcp_cubit.dart';

class EditServer extends StatefulWidget {
  const EditServer({super.key});

  @override
  State<EditServer> createState() => _EditServerState();
}

class _EditServerState extends State<EditServer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}