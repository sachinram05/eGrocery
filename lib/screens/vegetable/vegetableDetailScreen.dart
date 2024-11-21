import 'package:egrocery/models/cartModel.dart';
import 'package:egrocery/models/vegetableModel.dart';
import 'package:egrocery/providers/cartProvider.dart';
import 'package:egrocery/providers/vegetableProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VegetableDetailScreen extends ConsumerWidget {
  const VegetableDetailScreen({super.key, required this.vegetableData});
  final VegetableModel vegetableData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VegetableModel vegetable = ref.watch(vegetableProvider).firstWhere((VegetableModel veg) => veg.id == vegetableData.id);

    return Scaffold(
        body: SafeArea(
      child: Container(
                width: double.infinity,
               height: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.326,
                child: Image.asset(vegetable.vegetableImage, fit: BoxFit.cover),
              ),
              Positioned(top: 10,left: 10,child: GestureDetector(onTap: () {Navigator.pop(context);},
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2),shape: BoxShape.circle),
                      child: const Icon(Icons.clear,color: Colors.white,size: 34,weight: 400),
                    ),
                  )),
              Positioned(top: MediaQuery.of(context).size.height * 0.3,left: 0,right: 0,bottom: 0,
                  child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( vegetable.vegetableName,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(vegetable.vegetablePrice.toString(),overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall),
                                  const SizedBox(width: 10),
                                  Text('€ / ${vegetable.vegetableWeight}',style: Theme.of(context).textTheme.displayMedium)
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(vegetable.vegetableLocation,overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(height: 20),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  child: SingleChildScrollView(child: Text(vegetable.vegetableDescription,style: Theme.of(context).textTheme.displaySmall),
                                  )),
                              const SizedBox(height: 20),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        ref.watch(vegetableProvider.notifier).asFavorite(vegetable.id,vegetable.isFavorite);
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(vegetable.isFavorite? "Added as favorite": 'Removed as favorite')));
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14.0)),
                                      child: vegetable.isFavorite? const Icon(Icons.favorite,color: Color.fromARGB(255, 135, 22, 14)) : const Icon(Icons.favorite_outline_rounded, color: Colors.black,)),
                                     const SizedBox(width: 8),
                                 Expanded(child: ElevatedButton(
                                      onPressed: () {
                                        ref.watch(cartvegetableProvider.notifier).addItemInCart(CartModel(vegetableId: vegetable.id,vegetableName:vegetable.vegetableName,vegetableImage:vegetable.vegetableImage,vegetablePrice: vegetable.vegetablePrice,quantity: 1));
                          
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Added to your cart")));
                                      },
                                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14.0)),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart_outlined),
                                          Text(" ADD TO CART")
                                        ],
                                      )))
                                ],
                              ),
                            ],
                            // ),
                          ),
                        ),
                  )
            ]),
          )),
    );
  }
}
