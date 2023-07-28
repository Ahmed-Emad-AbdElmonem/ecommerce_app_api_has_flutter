import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/layout/layout_states.dart';
import 'package:ecommerce_api_hashim/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12.5,
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'search',
                    suffixIcon: const Icon(Icons.clear),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                
               const SizedBox(width: 12,),
                ListView.builder(
                  itemCount: cubit.favourites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12.5),
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: [
                          Image.network(
                            cubit.favourites[index].image!,
                            width: 120,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(cubit.favourites[index].name!,maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                overflow: TextOverflow.ellipsis,
                              ),
                              ),
                              const SizedBox(width: 5,),
                              Text('${cubit.favourites[index].price!}\$'),
                              MaterialButton(
                                onPressed: (){

                                //  add || remove
                                cubit.addOrRemoveFromFavourites(productID: cubit.favourites[index].id.toString());

                              },
                              child: const Text('remove'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
