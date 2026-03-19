import 'dart:developer';

import 'package:api_integrations/bloc/user/user_event.dart';
import 'package:api_integrations/bloc/user/user_state.dart';
import 'package:api_integrations/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  UserBloc(this.repository) : super(UserIntial()) {
    on<FetchUserEvent>((event, emit) async {
      log("📢 FetchUserEvent triggered");
      emit(UserLoading());
      try {
        final users = await repository.getUsers();
        log("✅ Users loaded: ${users.length}");

        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
        log("$e.toString()");
      }
    });
  }
}
