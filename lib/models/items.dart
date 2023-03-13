import 'dart:io';

class socketList {
  String address;
  int port;
  List? message = [];
  socketList({required this.address, required this.port, this.message});
}
