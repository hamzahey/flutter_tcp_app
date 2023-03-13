import 'dart:io';
import 'package:equatable/equatable.dart';

class SocketListState extends Equatable {
  final List<Socket> sockets;

  SocketListState({required this.sockets});

  @override
  List<Object?> get props => [sockets];
}


