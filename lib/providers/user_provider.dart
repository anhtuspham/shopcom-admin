import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/user.dart';

class UserState {
  final User user;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const UserState(
      {required this.user,
        this.isLoading = false,
        this.isError = false,
        this.errorMessage});

  factory UserState.initial() => UserState(user: User.empty());

  UserState copyWith(
      {User? user, bool? isLoading, bool? isError, String? errorMessage}) {
    return UserState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState.initial());

  Future<void> getUserInfo() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final user = await api.getUserInfo();
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

  Future<bool> updateUserInfo({
    String? name,
    String? email,
    String? password,
    String? address,
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    try{
      final result = await api.editUser(name: name, email: email, password: password, address: address);
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
      final user = await api.getUserInfo();
      state = state.copyWith(user: user, isLoading: false);
    } catch(e){
      state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final notifier = UserNotifier();
  notifier.getUserInfo();
  return notifier;
});
