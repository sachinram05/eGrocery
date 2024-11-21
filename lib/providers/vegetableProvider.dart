import 'package:egrocery/dummyData/vegetableData.dart';
import 'package:egrocery/models/vegetableModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vegetableProvider = StateNotifierProvider<VegetableNotifier, List<VegetableModel>>((ref) => VegetableNotifier());

class VegetableNotifier extends StateNotifier<List<VegetableModel>> {
  VegetableNotifier() : super(vegetableData);

  List<String> selectedFilterList = [];

  asFavorite(id, value) {
    state = state.map((VegetableModel veg) {
      if (veg.id == id) veg.isFavorite = !value;
      return veg;
    }).toList();
  }

  void filterVeg(filterValue) {
    final checkList = selectedFilterList.contains(filterValue);

    if (checkList) {
      selectedFilterList.removeWhere((item) => item == filterValue);
    } else {
      selectedFilterList = [...selectedFilterList, filterValue];
    }
    if (selectedFilterList.isEmpty) {
      state = vegetableData;
    } else {
      List<VegetableModel> listProducts = [];
      for (var i = 0; i < selectedFilterList.length; i++) {
        List<VegetableModel> filteredOne = vegetableData
            .where((item) => item.vegetableCategory.title == selectedFilterList[i])
            .toList();

        listProducts.addAll(filteredOne);
      }
      state = listProducts;
    }
  }

  void searchVegetables(searchValue) {
    selectedFilterList = [];

    if (searchValue == null || searchValue.isEmpty) {
      state = vegetableData;
    } else {
      List<VegetableModel> listVeg = vegetableData
          .where((item) =>
              item.vegetableName.toLowerCase().contains(searchValue.toLowerCase()) ||
              item.vegetablePrice.toString().contains(searchValue.toLowerCase()) ||
              item.vegetableLocation.toLowerCase().contains(searchValue.toLowerCase())||
              item.vegetableWeight.toString().contains(searchValue.toLowerCase().toLowerCase())).toList();

      state = listVeg;
    }
  }
}
