import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';



abstract class TcpState extends Equatable {
  const TcpState();

  @override
  List<Object?> get props => [];
}

class connecting extends TcpState{}

class connected extends TcpState{}

class disconnected extends TcpState{}

class error extends TcpState{}

class SocketListState extends TcpState {
  final List<Socket> sockets;

  SocketListState({required this.sockets});

  @override
  List<Object?> get props => [sockets];
}

