import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/layout/layout_states.dart';
import 'package:ecommerce_api_hashim/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  final pageController = PageController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
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
                const SizedBox(
                  height: 20,
                ),
                cubit.banners.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 125,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Image.network(
                                cubit.banners[index].imgUrl!,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 3,
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 16,
                        dotHeight: 16.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.indigo),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                     Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                cubit.categories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.categories.length,
                          itemBuilder: (context, index) {
                            return CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                cubit.categories[index].imgUrl!,
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Products',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                cubit.products.isEmpty
                    ? const CircularProgressIndicator()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.8),
                        itemCount:cubit.filteredProductsList.isEmpty ?
                         cubit.products.length
                         : cubit.filteredProductsList.length
                         ,
                        itemBuilder: (BuildContext context, int index) {
                          return productItem(model:
                          cubit.filteredProductsList.isEmpty?
                           cubit.products[index] :
                           cubit.filteredProductsList[index],
                           layoutCubit: cubit,
                           
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

Widget productItem({
  required ProductModel model, required LayoutCubit layoutCubit,
}) {
  return Container(
    color: Colors.grey.withOpacity(0.2),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: Column(
      children: [
        Expanded(
          child: Image.network(
            model.image!,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Text(
                  '${model.price!}\$',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  '${model.oldPrice!}\$',
                  style: const TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                GestureDetector(
                  child:  Icon(
                    Icons.favorite,
                    size: 20,
                    color: layoutCubit.favouritesID.contains(model.id.toString()) ? Colors.red : Colors.grey,
                  ),
                  onTap: () {
                  // add or remove product favourite
                  layoutCubit.addOrRemoveFromFavourites(productID: model.id.toString());

                  },
                )
              ],
            ))
          ],
        )
      ],
    ),
  );
}
