import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/cubits/socket_list/socket_cubit.dart';
import 'package:tcp/cubits/tcp_cubits/tcp_cubit.dart';
import 'models/items.dart';
import 'pages/home.dart';
import 'pages/server.dart';

List<socketList> items = [];

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final socketListCubit = SocketListCubit();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TcpCubit>(create: (context) => TcpCubit()),
        BlocProvider<SocketListCubit>(create: (context) => SocketListCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/server': (context) => TcpClient()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
