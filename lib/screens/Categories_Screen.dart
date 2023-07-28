import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesData=BlocProvider.of<LayoutCubit>(context).categories;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          mainAxisSpacing: 12,
        ),
        itemCount: categoriesData.length,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(categoriesData[index].imgUrl!,fit: BoxFit.fill,)),
              const  SizedBox(height: 10,),
                Text(categoriesData[index].title!)
              ],
            ),
          ) ;
        },
      ),
    );
  }
}