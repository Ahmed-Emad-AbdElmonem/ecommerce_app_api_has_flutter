import 'package:shared_preferences/shared_preferences.dart';
class CacheNetwork {

static late SharedPreferences sharedPref;

static Future sharedInit()async{
  sharedPref =await SharedPreferences.getInstance();
 }

static Future<bool>  inserToCache({required String key,required String value,})async{
return await sharedPref.setString(key, value);
 }
  
static  String getcache({required String key}){
   return  sharedPref.getString(key) ?? '' ;

  }

  static Future<bool> removecache({required String key}){
   return  sharedPref.remove(key);

  }
}