class HomeProductModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  HomeProductModel(
      {required this.description,
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.price});
}
