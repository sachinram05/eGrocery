import 'package:egrocery/models/cartModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartvegetableProvider =
    StateNotifierProvider<CartNotifier, List<CartModel>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartModel>> {
  CartNotifier() : super([]);

  addItemInCart(CartModel item) {
    final existItem = state.indexWhere((cartItem) => cartItem.vegetableId == item.vegetableId);
    if (existItem >= 0) {
      final updateData = state[existItem].copyWith(quantity: state[existItem].quantity + 1);
      state = [...state]..[existItem] = updateData;
    } else {
      state = [...state, item];
    }
  }

  removeItem(id) {
    state = state.where((item) => item.vegetableId != id).toList();
  }

  decrementItem(CartModel item) {
    final existItem = state.indexWhere((cartItem) => cartItem.vegetableId == item.vegetableId);
    if (existItem >= 0) {
      final currentItem = state[existItem];
      if (currentItem.quantity > 1) {
        final updateData = state[existItem].copyWith(quantity: currentItem.quantity - 1);
        state = [...state]..[existItem] = updateData;
      } else {
        removeItem(item.vegetableId);
      }
    }
  }
}
