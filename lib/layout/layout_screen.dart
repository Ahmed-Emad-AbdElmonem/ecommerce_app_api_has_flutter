import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener:  (context, state) {
        
      },
      builder:  (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Color.fromARGB(255, 241, 209, 112),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:cubit.bottomNavIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          cubit.changebottomNavIndex(index: value);
        },
        items: const [
        BottomNavigationBarItem(

          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
          ),
          label: 'categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: 'favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
          ),
          label: 'cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'profile',
        ),
      ]),
      body: cubit.layoutScreens[cubit.bottomNavIndex] ,
    );
      }, );
  }
}
