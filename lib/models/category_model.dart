class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  CategoryModel({required this.name, required this.imageUrl, required this.id});
  factory CategoryModel.fromJson(Map<String, dynamic> item) {
    return CategoryModel(
      id: item['id'] ?? "",
      name: item['name'] ?? "",
      imageUrl: item['img_url'] ?? "",
    );
  }
}
