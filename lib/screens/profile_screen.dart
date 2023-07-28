import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title:const Text('Profile'),
          ),
          body: cubit.userModel != null ? 
          Column(
            children: [
            Text('${cubit.userModel?.email}'), 
            Text('${cubit.userModel?.name}'),
            Text('${cubit.userModel?.phone}'),  
            ],
          ) :Center(child: CircularProgressIndicator()),
           
        );
      },
    );
  }
}
