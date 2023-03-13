import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:tcp/cubits/tcp_cubits/tcp_state.dart';
import 'package:tcp/models/items.dart';

import '../socket_list/socket_cubit.dart';

// enum TcpState { connecting, connected, disconnected, error }

class TcpCubit extends Cubit<TcpState> {
  
  TcpCubit() : super(disconnected());

  Socket? _socket;
  
  Future<void> connect(String host, int port) async {
    if (state != disconnected()) {
      return;
    }

    emit(connecting());

    try {
      _socket = await Socket.connect(host, port);
      
      
      print(
          'Connected to: ${_socket!.remoteAddress.address}:${_socket!.remotePort}');

      emit(connected());
      _listen();
    } on SocketException catch (e) {
      print('Socket error: $e');
    } catch (e) {
      emit(error());
    }
  }

  Future<void> disconnect() async {
    if (state != connected()) {
      return;
    }
    try {
      await _socket?.close();
      _socket = null;
      emit(disconnected());
    } on SocketException catch (e) {
      print('Socket error: $e');
    } catch (e) {
      emit(error());
    }
  }

  void send(String message) {
    if (state != connected()) {
      return;
    }
    try {
      _socket?.write(message);
      print('Sent message: $message');
    } on SocketException catch (e) {
      print('Socket error: $e');
    } catch (e) {
      emit(error());
    }
  }

  void _listen() {
    try {
      _socket?.listen((List<int> data) {
        final message = String.fromCharCodes(data);
        print('Received message: $message');
      }, onError: (error) {
        print('Error occurred: $error');
        _socket?.destroy();
        emit(error());
      }, onDone: () {
        print('Connection closed by server');
        _socket?.destroy();
        emit(disconnected());
      });
    } on SocketException catch (e) {
      print('Socket error: $e');
    } catch (e) {
      emit(error());
    }
  }
}
