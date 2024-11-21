import 'package:egrocery/actions/authActions.dart';
import 'package:egrocery/constants/authConstant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AuthActions authActions = AuthActions();

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(LoadingAuthState(isLoading: true));

  Future<void> loginUser(data) async {
    try {
      Map<String, Object> response = await authActions.loginUser(data);

      if (response['status'] == true) {
        state = LoadedAuthState(message: 'Welcome to the eGrocery app', isLoading: false);
      } else {
        state = ErrorAuthState(message: response['message'].toString(), isLoading: false);
      }

    } catch (err) {
      state = ErrorAuthState(message: err.toString(), isLoading: false);
    }
  }
  
  Future<void> registerUser(data) async {
    try {
      Map<String, Object> response = await authActions.registerUser(data);

      if (response['status'] == true) {
        state = LoadedAuthState(message: response['message'].toString(), isLoading: false);
      } else {
        state = ErrorAuthState( message: response['message'].toString(), isLoading: false);
      }
      
    } catch (err) {
      state = ErrorAuthState(message: err.toString(), isLoading: false);
    }
  }
}
