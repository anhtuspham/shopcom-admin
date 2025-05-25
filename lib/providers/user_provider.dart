import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/user.dart';

class UserState {
  final List<User> user;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const UserState(
      {required this.user,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory UserState.initial() => const UserState(user: []);

  UserState copyWith(
      {List<User>? user, bool? isLoading, bool? isError, String? errorMessage}) {
    return UserState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState.initial());

  Future<void> fetchUsers() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final user = await api.fetchUsers();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    await _updateUserState();
  }

  Future<bool> createUser({String? name, String? email, String? password, String? address, bool? isAdmin}) async{
    state = state.copyWith(isLoading: true, isError: false);
    try{
      final result = await api.createUser(name: name, email: email, password: password, address: address, isAdmin: isAdmin);
      if (result.isValue) {
        await _updateUserState();
        return true;
      } else {
        state = state.copyWith(isLoading: false, isError: true, errorMessage: "Failed to create user");
        return false;
      }
    } catch(e){
      state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
}

  Future<bool> updateUserInfo({
    required String id,
    String? name,
    String? email,
    String? password,
    String? address,
    bool? isAdmin
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    try{
      final result = await api.editUser(id: id, name: name, email: email, password: password, address: address, isAdmin: isAdmin);
      if (result.isValue) {
        await _updateUserState();
        return true;
      } else {
        state = state.copyWith(isLoading: false, isError: true, errorMessage: "Failed to update info");
        return false;
      }
    } catch(e){
      state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> _updateUserState() async{
    try{
      final user = await api.fetchUsers();
      state = state.copyWith(user: user, isLoading: false);
    } catch(e){
      state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final notifier = UserNotifier();
  notifier.fetchUsers();
  return notifier;
});
