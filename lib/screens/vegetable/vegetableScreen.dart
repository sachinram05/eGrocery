import "package:egrocery/models/cartModel.dart";
import "package:egrocery/models/vegetableModel.dart";
import "package:egrocery/providers/cartProvider.dart";
import "package:egrocery/providers/vegetableProvider.dart";
import "package:egrocery/screens/vegetable/vegetableDetailScreen.dart";
import "package:egrocery/widgets/searchTitle.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class VegetableScreen extends ConsumerWidget {
  const VegetableScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<VegetableModel> vegetableData = ref.watch(vegetableProvider);
    final categoryList = categoriesData.entries.toList();

    onChangeHandler(value) {
      ref.read(vegetableProvider.notifier).searchVegetables(value);
    }

  
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
               children: [
                SearchTitle(title: 'Vegetables', onChangeHandler: onChangeHandler),
                Container(alignment: Alignment.center,height: 40,
                  child: ListView.builder( scrollDirection: Axis.horizontal,itemCount: categoryList.length, itemBuilder: (context, index) {
                       return GestureDetector(
                         onTap: () {
                              print("Selected: ${categoryList[index].value.title}");
                           ref.read(vegetableProvider.notifier).filterVeg(categoryList[index].value.title);
                    },
                    child: Container(margin: const EdgeInsets.symmetric(horizontal: 8.0),padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration( color: ref.read(vegetableProvider.notifier).selectedFilterList.contains(categoryList[index].value.title) ? Colors.purple[100]: Colors.grey[200], borderRadius: BorderRadius.circular(20.0)),
                      child: Text( categoryList[index].value.title,style: TextStyle(color: ref.read(vegetableProvider.notifier).selectedFilterList.contains(categoryList[index].value.title)? Colors.purple : Colors.black,fontWeight: FontWeight.w500)),
                    ),
                  );
                }),
          ),
          vegetableData.isEmpty?Expanded(
                  child: Center(
                      child: 
                     Text("Vegetables not found!",style:Theme.of(context).textTheme.headlineMedium))):
          Expanded(
              child: ListView.builder(padding: EdgeInsets.zero,itemCount: vegetableData.length, itemBuilder: (context, index) {
                    VegetableModel vegetable = vegetableData[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push( context,
                                MaterialPageRoute( builder: (context) => VegetableDetailScreen(vegetableData: vegetable)));
                          },
                          child: Container(alignment: AlignmentDirectional.topStart, height: MediaQuery.of(context).size.height * 0.14,margin: const EdgeInsets.all(8),
                              child: Row( mainAxisAlignment:MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( 
                                      clipBehavior: Clip.hardEdge, 
                                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width * 0.44,
                                      height:MediaQuery.of(context).size.height * 0.14,
                                      child: Image.asset(vegetable.vegetableImage,fit: BoxFit.fill )),
                                  const SizedBox( width: 4),
                                  Expanded(
                                    child: Padding(padding: const EdgeInsets.symmetric( vertical: 0, horizontal: 4),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            children: [
                                              Text(vegetable.vegetableName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                              Row(
                                                children: [
                                                  Text(vegetable.vegetablePrice.toString(),style: Theme.of(context).textTheme.labelLarge),
                                                  const SizedBox( width: 10),
                                                  Text('€ / ${vegetable.vegetableWeight}', style: Theme.of(context).textTheme.displaySmall)
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      ref.read(vegetableProvider.notifier).asFavorite(vegetable.id,vegetable.isFavorite);
                                                      ScaffoldMessenger.of( context).clearSnackBars();
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text(vegetable.isFavorite? "Added as favorite": 'Removed as favorite')));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                            backgroundColor:  Colors.white),
                                                            child: vegetable.isFavorite
                                                                 ? const Icon(Icons.favorite,color: Color.fromARGB( 255, 179, 33, 22))
                                                                 : const Icon(Icons.favorite_outline_rounded,color: Colors.black,)),
                                              ),
                                              const SizedBox(width: 8,),
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      ref.watch(cartvegetableProvider.notifier).addItemInCart(CartModel(
                                                              vegetableId:vegetable.id,
                                                              vegetableName:vegetable.vegetableName,
                                                              vegetableImage:vegetable.vegetableImage,
                                                              vegetablePrice:
                                                                  vegetable
                                                                      .vegetablePrice,
                                                              quantity: 1));
                                                               ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              content: Text("Added to your cart")));
                                                    },
                                                    child: const Icon(Icons
                                                        .shopping_cart_outlined)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  }))
        ]));
  }
}
