enum VegetableCategories {
  cabbageAndLettuce,
  cucumbersAndTomato,
  onionsAndGarlic,
  peppers,
  potatoes
}

class Category {
  const Category(this.title);
  final String title;
}

const categoriesData = {
  VegetableCategories.cabbageAndLettuce: Category('Cabbage And Lettuce'),
  VegetableCategories.cucumbersAndTomato: Category('Cucumbers And Tomato'),
  VegetableCategories.onionsAndGarlic: Category('Onions And Garlics'),
  VegetableCategories.peppers: Category('Peppers'),
  VegetableCategories.potatoes: Category('Potatoes & Carrots'),
};

class VegetableModel {
   VegetableModel(
      {required this.id,
      required this.vegetableName,
      required this.vegetableImage,
      required this.vegetablePrice,
      required this.vegetableLocation,
      required this.vegetableWeight,
      required this.vegetableDescription,
      required this.vegetableCategory,
       required this.isFavorite
      });

  final int id;
  final String vegetableName;
  final String vegetableImage;
  final double vegetablePrice;
  final String vegetableWeight;
  final String vegetableLocation;
  final String vegetableDescription;
  final Category vegetableCategory;
   bool isFavorite;
}
