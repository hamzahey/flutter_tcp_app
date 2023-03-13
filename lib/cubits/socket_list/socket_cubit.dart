import 'package:bloc/bloc.dart';

import 'dart:io';

import 'package:tcp/cubits/socket_list/socket_state.dart';

class SocketListCubit extends Cubit<SocketListState> {
  SocketListCubit() : super(SocketListState(sockets: []));

  void addSocket(Socket socket) {
    final updatedSockets = List<Socket>.from(state.sockets)..add(socket);
    emit(SocketListState(sockets: updatedSockets));
  }
}
