import "package:egrocery/models/cartModel.dart";
import "package:egrocery/providers/cartProvider.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<CartModel> cartDataList = ref.watch(cartvegetableProvider);
    final cartDataListNotifier = ref.read(cartvegetableProvider.notifier);
    double subtotal = cartDataList.isNotEmpty ? cartDataList .map((item) => item.vegetablePrice * item.quantity) .reduce((value, element) => value + element) : 0;
    double gst = 18 / 100 * subtotal;
    double deliveryCharge = 120;

    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( 'Shoping Cart', style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          cartDataList.isEmpty
              ?  Expanded(
                  child: Center(child: Text("Your Cart is empty!",style:Theme.of(context).textTheme.headlineMedium)))
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.44,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cartDataList.length,
                      itemBuilder: (context, index) {
                        CartModel cartdata = cartDataList[index];
                        return Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          backgroundImage: AssetImage(
                                              cartdata.vegetableImage),
                                          backgroundColor: Colors.transparent),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartdata.vegetableName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${cartdata.vegetablePrice.toString()} € / Kg',
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              cartDataListNotifier
                                                  .decrementItem(cartdata);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 30,
                                            )),
                                        Text(cartdata.quantity.toString()),
                                        IconButton(
                                            onPressed: () {
                                              cartDataListNotifier
                                                  .addItemInCart(cartdata);
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          (cartdata.vegetablePrice *
                                                  cartdata.quantity)
                                              .toStringAsFixed(2),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartDataListNotifier.removeItem(
                                                  cartdata.vegetableId);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 159, 28, 18),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
          const SizedBox(height: 10),
         if(cartDataList.isNotEmpty)  Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text("Subtotal"), Text("${subtotal.toStringAsFixed(2)} €")],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("GST"),
                      Text("${gst.toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charge"),
                      Text("${deliveryCharge.toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total"),
                      Text(
                          "${(subtotal + deliveryCharge + gst).toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                        onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Work on progress!")));
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 54.0, vertical: 14.0)),
                        child: const Text("Proceed to Payment")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
