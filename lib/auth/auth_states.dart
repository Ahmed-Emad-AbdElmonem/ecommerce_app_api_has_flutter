abstract class AuthStates {}
class AuthInitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}
class RegisterSuccessState extends AuthStates {}
class RegisterErrorState extends AuthStates {
   String message;
   RegisterErrorState({required this.message});
}



class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
   String message;
   LoginErrorState({required this.message});
}