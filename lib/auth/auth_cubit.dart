import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_api_hashim/auth/auth_states.dart';
import 'package:ecommerce_api_hashim/shared/local_network.dart';
import 'package:http/http.dart'as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  register({
    required String name,
    required String email,
    required String phone,
    required String password,
  })async {
    emit(RegisterLoadingState());
   http.Response response = await http.post(Uri.parse('https://student.valuxapps.com/api/register'),
    body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    }
    
    
    );
    
   var responseBody = jsonDecode(response.body);
   if (responseBody['status']== true) {
     
     emit(RegisterSuccessState());
   }else{
    emit(RegisterErrorState(message: responseBody['message']),);
   }
  }



 login({required String email,required String password,})async{
  emit(LoginLoadingState());
 try {
  http.Response response= await http.post(
     Uri.parse('https://student.valuxapps.com/api/login'),
     
     body: {
       'email':email,
       'password':password,
  
     }
     
  
     );
     if (response.statusCode==200) {
      var data =jsonDecode(response.body);
      if (data['status']==true) {
        await CacheNetwork.inserToCache(key: 'token',value: data['data']['token']);
        emit(LoginSuccessState());
      }else{
        emit(LoginErrorState(message:data['message']),);
      }
       
     }
} on Exception catch (e) {
  emit(LoginErrorState(
    message:  e.toString(),
   ));
}
  

 }

}
