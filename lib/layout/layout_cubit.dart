import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_api_hashim/constants/constants.dart';
import 'package:ecommerce_api_hashim/layout/layout_states.dart';
import 'package:ecommerce_api_hashim/models/banner_model.dart';
import 'package:ecommerce_api_hashim/models/category_model.dart';
import 'package:ecommerce_api_hashim/models/product_model.dart';
import 'package:ecommerce_api_hashim/models/user_model.dart';
import 'package:ecommerce_api_hashim/screens/Cart_Screen.dart';
import 'package:ecommerce_api_hashim/screens/Categories_Screen.dart';
import 'package:ecommerce_api_hashim/screens/Fav_Screen.dart';
import 'package:ecommerce_api_hashim/screens/home.dart';
import 'package:ecommerce_api_hashim/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  UserModel? userModel;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    http.Response response = await http.get(
        //////////////////////////////////////////////
        Uri.parse('www.google.com/endpoint'),
        headers: {
          'Authorization': token!,
        });

    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);
      emit(GetUserDataSuccessState());
    } else {
      emit(GetUserDataErrorState(error: responseData['message']));
    }
  }

  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  void changebottomNavIndex({required int index}) {
    bottomNavIndex = index;

    emit(ChangebottomNavIndex());
  }

  List<BannerModel> banners = [];
  void getBanners() async {
    http.Response response =
        await http.get(Uri.parse('https://student.valuxapps.com/api/banners'));
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannersSuccessstate());
    } else {
      emit(GetBannersErrorstate());
    }
  }

  List<CategoryModel> categories = [];
  void getCategories() async {
    http.Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/categories'));
    final responseBody = jsonDecode(response.body);
    if (responseBody['data'] == true) {
      for (var item in responseBody['data']['data']) {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategorisSuccessstate());
    } else {
      emit(GetCategorisErrorstate());
    }
  }

  List<ProductModel> products = [];
  void getProducts() async {
    http.Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/home'), headers: {
      'Authorization': token!,
    });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(ProductModel.fromJson(data: item));
      }
      emit(GetProductsSuccessstate());
    } else {
      emit(GetProductsErrorstate());
    }
  }

  List<ProductModel> filteredProductsList = [];
  void filteredProducts({required String input}) {
    filteredProductsList = products
        .where((element) => element.name!.toLowerCase().startsWith(
              input.toLowerCase(),
            ))
        .toList();
  }

  List<ProductModel> favourites = [];
  Set<String> favouritesID ={};
  Future<void> getFavourites() async {
    favourites.clear();
    http.Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favourites'),
        headers: {'Authorization': token!});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        favourites.add(ProductModel.fromJson(data: item['product']));
        favouritesID.add(item['product']['id'].toString());
      }
      emit(GetFavouritesSuccessstate());
    } else {
      emit(GetFavouritesErrorstate());
    }
  }




  void addOrRemoveFromFavourites({required String productID}) async {
    http.Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favourites'),
        headers: {
          'lang': 'en',
          'Authorization': token!
        },
        body: {
          'product_id': productID,
        });

        var responseBody = jsonDecode(response.body);
        if (responseBody['status']==true) {
   if (favouritesID.contains(productID)==true) {
    // delete
    favouritesID.remove(productID);
     
   }else{
    // add
    favouritesID.add(productID);
   }
          emit(AddOrRemoveFromFavouritesSuccessState());
          
        }else{
          await getFavourites();
          emit(AddOrRemoveFromFavouritesErrorState());
        }
  }
}
