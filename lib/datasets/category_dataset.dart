class CategoryDataset {
  final int categoryId;
  final String name;
  final String description;
  final String imagePath;

  CategoryDataset(
      {this.categoryId, this.name, this.description, this.imagePath});

  factory CategoryDataset.fromJson(Map<String, dynamic> json) {
    return CategoryDataset(
        categoryId: json['categoryId'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        imagePath: json['imagePath'] as String);
  }
}
